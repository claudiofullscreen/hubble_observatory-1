require 'spec_helper'

describe 'HubbleApiClient::Configuration' do
  after :all do
    HubbleApiClient.configure do |config|
      config.app_access_token = ENV['HUBBLE_APP_TOKEN']
      config.environment = "staging"
    end
  end

  it 'should return nil if no block is given' do
    expect(HubbleApiClient.configure).to be(nil)
  end

  describe "given a block with the app_access_token and environment" do
    before do
      HubbleApiClient.configure do |config|
        config.app_access_token = '123xyz'
        config.environment = "staging"
      end
    end
    it 'should change the Configuration#app_access_token and the host_url' do
      expect(HubbleApiClient.configuration.app_access_token).to eq('123xyz')
      expect(HubbleApiClient.configuration.host_url).to eq('stage-hubble.fullscreen.net')
    end
  end
end
