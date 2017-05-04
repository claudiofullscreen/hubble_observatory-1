require 'spec_helper'

describe 'HubbleApiClient::Configuration' do
  after :all do
    HubbleApiClient.configure do |config|
      config.app_access_token = ENV['HUBBLE_APP_TOKEN']
    end
  end

  it 'should return nil if no block is given' do
    expect(HubbleApiClient.configure).to be(nil)
  end

  describe "given a block with: { |config| config.app_access_token = '123xyz' }" do
    before do
      HubbleApiClient.configure { |config| config.app_access_token = '123xyz' }
    end
    it 'should change the Configuration#app_access_token to 123xyz' do
      expect(HubbleApiClient.configuration.app_access_token).to eq('123xyz')
    end
  end
end
