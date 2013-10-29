require "vagrant"

module VagrantPlugins
  module GithubKeyManager
    class Config < Vagrant.plugin("2", :config)
      attr_accessor :endpoint

      def initialize(region_specific=false)
        @endpoint = 'https://api.github.com/user/keys'
      end

    end
  end
end

