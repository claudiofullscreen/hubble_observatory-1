require 'spec_helper'

describe 'HubbleApiClient::Configuration' do
  after :all do
    HubbleApiClient.configure do |config|
      config.app_access_token = ENV['HUBBLE_APP_TOKEN']
      config.host_url = ENV['HUBBLE_API_URL']
    end
  end

  it 'should return nil if no block is given' do
    expect(HubbleApiClient.configure).to be(nil)
  end

  describe "given a block with: { |config| config.app_access_token = '123xyz' }" do
    before do
      HubbleApiClient.configure do |config|
        config.app_access_token = '123xyz'
        config.host_url = '123xyz'
      end
    end
    it 'should change the Configuration#app_access_token to 123xyz' do
      expect(HubbleApiClient.configuration.app_access_token).to eq('123xyz')
      expect(HubbleApiClient.configuration.host_url).to eq('123xyz')
    end
  end
end
