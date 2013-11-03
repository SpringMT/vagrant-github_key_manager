require "vagrant-github_key_manager/config"

describe VagrantPlugins::GithubKeyManager::Config do
  let(:instance) { described_class.new }

  describe :initialize do

    context 'default' do
      subject {instance}
      it do
        expect(instance.github_api_url).to eq 'https://api.github.com/user/keys'
      end
    end

  end
end

