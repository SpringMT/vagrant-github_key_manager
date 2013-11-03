module VagrantPlugins
  module GithubKeyManager
    module Action
      class DeleteKey
        def initialize(app, env)
          @app = app
          @ui = env[:ui]
          @machine = env[:machine]
        end

        def call(env)
          config = env[:global_config].github_key_manager
          github_api_uri = config.github_api_uri

          #@ui.info("We will now generate an ssh key and add it to your github account.")
          #gitUsername = @ui.ask("What is your github account name? ")
          #gitPassword = @ui.ask("What is your github account password? (not stored) ", echo: false)

          #@machine.communicate.execute("curl -X DELETE -u #{gitUsername}:#{gitPassword} #{endpoint}")
          @ui.info(github_api_uri)
          @ui.info("delete ssh key")
          @app.call(env)
        end

      end
    end
  end
end


