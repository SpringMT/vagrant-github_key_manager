require 'shellwords'

module VagrantPlugins
  module GithubKeyManager
    module Action
      class AddKey

        def initialize(app, env)
          @app = app
          @ui = env[:ui]
          @machine = env[:machine]
        end

        def call(env)
          config = env[:global_config].github_key_manager
          endpoint = config.endpoint

          script = ["GITHUB_USERNAME=$1", "GITHUB_PASSWORD=$2"]
          script.concat(["ssh-keygen -N '' -f ~/.ssh/github_rsa", "ssh-add ~/.ssh/github_rsa"])
          script.concat(["set -- $(<~/.ssh/github_rsa.pub)", 'JSON=\'{"title":"vagrant provision key", "key": "ssh-rsa \'$2\'"}\''])
          script.concat(['curl -u "$GITHUB_USERNAME:$GITHUB_PASSWORD" -d "$JSON "', endpoint, '> ~/.ssh/git.response'])

          # if we have a successful response, skip generating key
          unless @machine.communicate.test('grep '"id"' ~/.ssh/git.response')

            @machine.communicate.execute("echo '' > ~/.ssh/github.sh")
            # create script
            script.each {
                    |l|
                  e = Shellwords.escape(l);
                  @machine.communicate.execute("echo #{e} >> ~/.ssh/github.sh")
            }

            # set permissions for execution
            @machine.communicate.execute("chmod 755 ~/.ssh/github.sh")
            @machine.communicate.execute("cat ~/.ssh/github.sh")
            # execute script w/ permissions
            @ui.info("We will now generate an ssh key and add it to your github account.")
            gitUsername = @ui.ask("What is your github account name? ")
            gitPassword = @ui.ask("What is your github account password? (not stored) ", echo: false)

            @machine.communicate.execute("sh ~/.ssh/github.sh #{gitUsername} #{gitPassword}")
          end

          @ui.info("created ssh key")
          @app.call(env)
        end

      end
    end
  end
end


