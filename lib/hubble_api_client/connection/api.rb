require 'json'

module HubbleApiClient
  # @api private
  class API

    def self.get_request(route:, query:)
      uri = URI::HTTPS.build host: host,
        path: "#{api_path}/#{route}",
        query: query
      request = Net::HTTP::Get.new(uri.request_uri)
      response_for(assign_headers(request), uri)
    end

    def self.post_request(route:, body:)
      uri = URI::HTTPS.build host: host,
        path: "/api/v1/#{route}"
      request = Net::HTTP::Post.new uri
      request.body = body.to_json
      response_for(assign_headers(request), uri)
    end

    def self.put_request(route:, body:)
      uri = URI::HTTPS.build host: host,
        path: "/api/v1/#{route}"
      request = Net::HTTP::Put.new uri
      request.body = body.to_json
      response_for(assign_headers(request), uri)
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

    def self.response_for(http_request, uri)
      response = Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
        http.request http_request
      end
      response
    rescue SocketError => e
      raise ConnectionError, e.message
    end

    def self.assign_headers(request)
      headers.each_key do |header|
        request[header] = headers[header]
      end
      request
    end

    def self.headers
      {"Authorization" => "Bearer #{app_access_token}",
       "Content-Type" => "application/vnd.api+json"}
    end
  end
end
