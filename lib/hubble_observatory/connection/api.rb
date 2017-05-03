require 'hubble_observatory/connection/base'
require 'json'

module HubbleObservatory
  # @api private
  module Connection
    class API < Base

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

    private

      def self.host
        ENV['HUBBLE_API_URL']
      end

      def self.app_access_token
        HubbleObservatory.configuration.app_access_token
      end

      def self.post_http_request(uri)
        Net::HTTP::Post.new uri
      end

      def self.api_path
        "/api/v1"
      end
    end
  end
end
