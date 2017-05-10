require 'hubble_api_client/connection/base_connection'
require 'json'

module HubbleApiClient
  # @api private
  class API < BaseConnection

    def self.get_request(route_name:, query:)
      uri = URI::HTTPS.build host: host,
        path: "#{api_path}/#{route_name}",
        query: query
      response_for(get_http_request(uri), uri)
    end

    def self.post_request(route:, body:)
      uri = URI::HTTPS.build host: host,
        path: "/api/v1/#{route}"
      response_for(post_http_request(uri, body), uri)
    end

    def self.put_request(route:, body:)
      uri = URI::HTTPS.build host: host,
        path: "/api/v1/#{route}"
      response_for(put_http_request(uri, body), uri)
    end

  private

    def self.host
      HubbleApiClient.configuration.host_url
    end

    def self.app_access_token
      HubbleApiClient.configuration.app_access_token
    end

    def self.api_path
      "/api/v1"
    end
  end
end
