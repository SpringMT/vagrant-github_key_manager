begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant AWS plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant AWS plugin is only compatible with Vagrant 1.2+"
end

require 'vagrant-github_key_manager/action/add_key'
require 'vagrant-github_key_manager/action/delete_key'

module VagrantPlugins
  module GithubKeyManager
    class Plugin < Vagrant.plugin("2")
      name 'vagrant-github_key_manager'
      description <<-DESC
      DESC

      config 'github_key_manager' do
        require_relative "config"
        Config
      end

      action_hook(:github_key_manager, :machine_action_up) do |hook|
        hook.append Action::AddKey
      end

      action_hook(:github_key_manager, :machine_action_destroy) do |hook|
        hook.prepend Action::DeleteKey
      end

    end
  end
end


