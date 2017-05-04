module HubbleApiClient
  class Configuration
    attr_accessor :app_access_token

    def initialize
      @app_access_token = ENV['HUBBLE_APP_TOKEN']
    end
  end
end
