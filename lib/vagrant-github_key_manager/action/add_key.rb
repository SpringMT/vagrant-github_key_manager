require 'shellwords'
require 'json'
require 'net/https'
require 'uri'

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
          github_api_url = config.github_api_url
          ssh_key_title = config.ssh_key_title

          # if we have a successful response, skip generating key
          unless @machine.communicate.test('test -f ~/.ssh/github_key_id')

            @ui.info("We will now generate an ssh key and add it to your github account.")

            unless @machine.communicate.test('test -f ~/.ssh/github_rsa')
              @machine.communicate.execute('ssh-keygen -N "" -f ~/.ssh/github_rsa')
              @ui.info('Generate ssh key for github')
            end

            @ui.info("Register ssh key to your github account.")
            github_username = @ui.ask("What is your github account name? ")
            github_password = @ui.ask("What is your github account password? (not stored) ", echo: false)

            execute_script = <<EOF
require "rubygems"
require "json"
require "net/https"
require "uri"

ssh_pub_key = File.read File.expand_path("~/.ssh/github_rsa.pub")

uri = URI.parse "#{github_api_url}"
https = Net::HTTP.new(uri.host, uri.port)
https.use_ssl = uri.scheme == "https"
https.start do |https|
  req = Net::HTTP::Post.new(uri.path)
  req.basic_auth "#{github_username}", "#{github_password}"
  github_ssh_key_settings = {
    :title => "#{ssh_key_title}",
    :key   => ssh_pub_key
  }
  req.body = JSON.generate github_ssh_key_settings

  response = https.request(req)
  res_data = JSON.parse response.body
  github_ssh_key_id = res_data["id"]
  File.open(File.expand_path("~/.ssh/github_key_id"), "w") do |file|
    file.puts github_ssh_key_id
  end
end
`ssh-add -D`
`ssh-add ~/.ssh/github_rsa`
EOF
            @machine.communicate.execute("ruby -e '#{execute_script}'")
            #@machine.communicate.execute('eval $(ssh-agent)')
            #@machine.communicate.execute('ssh-add ~/.ssh/github_rsa')
            @ui.info("register ssh key to github")
          end

          @app.call(env)
        end

      end
    end
  end
end


