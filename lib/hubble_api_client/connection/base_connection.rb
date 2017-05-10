module HubbleApiClient
# @api private
  class BaseConnection

  private

    def self.get_http_request(uri)
      request = Net::HTTP::Get.new(uri.request_uri)
      assign_headers(request)
    end

    def self.post_http_request(uri, body)
      request = Net::HTTP::Post.new uri
      request.body = body.to_json
      assign_headers(request)
    end

    def self.put_http_request(uri, body)
      request = Net::HTTP::Put.new uri
      request.body = body.to_json
      assign_headers(request)
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
