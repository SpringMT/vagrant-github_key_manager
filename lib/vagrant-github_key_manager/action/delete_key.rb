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
          github_api_url = config.github_api_url


          #@machine.communicate.execute("curl -X DELETE -u #{gitUsername}:#{gitPassword} #{endpoint}")
          if @machine.communicate.test('test -f ~/.ssh/github_key_id')
            @ui.info("We will now delete the registered ssh key to your github account.")
            github_username = @ui.ask("What is your github account name? ")
            github_password = @ui.ask("What is your github account password? (not stored) ", echo: false)

            execute_script = <<EOF
require "rubygems"
require "json"
require "net/https"
require "uri"

github_ssh_key_id = (File.read File.expand_path("~/.ssh/github_key_id")).chomp

uri = URI.parse "#{github_api_url}"
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = uri.scheme == "https"
https.start do |https|
  req = Net::HTTP::Delete.new("\#{uri.path}/\#{github_ssh_key_id}")
  req.basic_auth "#{github_username}", "#{github_password}"
  response = https.request(req)
  File.delete File.expand_path("~/.ssh/github_key_id")
end
EOF
            @machine.communicate.execute("ruby -e '#{execute_script}'")
            @ui.info("delete ssh key")
          end
          @app.call(env)
        end

      end
    end
  end
end


