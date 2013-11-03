require "vagrant"

module VagrantPlugins
  module GithubKeyManager
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :github_api_url
      attr_accessor :ssh_key_title

      def initialize(region_specific=false)
        @github_api_url = 'https://api.github.com/user/keys'
        @ssh_key_title = 'vagrant provision key'
      end

    end
  end
end

