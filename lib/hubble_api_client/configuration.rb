module HubbleApiClient
  class Configuration
    attr_accessor :app_access_token, :host_url

    def initialize
      @app_access_token = ENV['HUBBLE_APP_TOKEN']
      @host_url = ENV['HUBBLE_API_URL']
    end
  end
end
