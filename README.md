# Vagrant::GithubKeyManager

On "vagrant up", generat an SSH key and register with your github.com or GH:E account.  
This allows the Guest VM to execute git statements without setting host machine ssh-agent and vagrant's forward_agent.

## Installation
### For vagrant

1. Clone vagrant-github_key_manager

	```
	git clone git@github.com:SpringMT/vagrant-github_key_manager.git
	```

1. Build gem

	```
	cd vagrant-github_key_manager.git
	gem build vagrant-github_key_manager.gemspec
	```

1. Register vagrant plugin

	```
	cd /path/to/vagrant-project
	vagrant plugin install /path/to/vagrant-github_key_manager/vagrant-github_key_manager-0.0.1.gem 
	```

### For gem
Add this line to your application's Gemfile:

    gem 'vagrant-github_key_manager'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vagrant-github_key_manager

## Usage
* Vagrantfile

```
Vagrant.configure("2") do |config|
  config.vm.box = "dummy"
  
  config.github_key_manager.github_api_url = 'YOUR GITHUB API URL' # default is 'https://api.github.com/user/keys'
  config.github_key_manager.ssh_key_title = 'YOUR KEY NAME' # default is 'vagrant provision key'

end
```

## Reference
* https://github.com/jeremygiberson/vagrant-gitcredentials
* http://developer.github.com/v3/

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
