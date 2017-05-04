require "hubble_api_client/version"
require "hubble_api_client/configuration"
require "hubble_api_client/request"
require "hubble_api_client/connection/api"

module HubbleApiClient
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
