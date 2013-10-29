require "vagrant-github_key_manager/config"

describe VagrantPlugins::GithubKeyManager::Config do
  let(:instance) { described_class.new }

  describe :initialize do

    context 'default' do
      subject {instance}
      it do
        expect(instance.endpoint).to eq 'https://api.github.com/user/keys'
      end
    end

  end
end

