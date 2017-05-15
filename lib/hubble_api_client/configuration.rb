module HubbleApiClient
  class Configuration
    attr_accessor :app_access_token, :environment
    attr_reader :host_url

    def initialize
      @app_access_token = ENV['HUBBLE_APP_TOKEN']
      @host_url = environment == "production" ? "production-hubble.fullscreen.net" : "stage-hubble.fullscreen.net"
    end
  end
end
