module HubbleObservatory
  # A wrapper around +Net::HTTP+ to send HTTP requests to the Hubble API and
  # return their result or raise an error if the result is unexpected.
  # The basic way to use Request is by calling +run_request+ on an instance.
  class Request
    # Initializes a Request object.
    # @param [Hash] attrs are the options for the request.
    # @option attrs [Symbol] :method (:get) The HTTP method to use.
    # @option attrs [String] :route The (base) route of the API endpoint
    # @option attrs [Hash] :body_attrs ({}) The attributes for the body
    # per the JSON API spec
    def initialize(attrs: {})
      @request_type = attrs.fetch :request_type, :get
      @route = attrs.fetch :route, "talent-accounts"
      @body_attrs = attrs.fetch :body_attrs, nil
      @error_message = attrs.fetch :error_message, ->(body) {"Error: #{body}"}
    end

    # Sends the request and returns the response
    def run_request
      net_http_class = Object.const_get("Net::HTTP::#{@request_type.capitalize}")
      request = net_http_class.new uri
      request.body = serialize_attributes(attributes: @body_attrs).to_json
      response_for(assign_headers(request), uri)
    end

    # parse the JSON response body
    def parse(response)
      JSON.parse response.body, symbolize_names: true
    end

    private

    def serialize_attributes(attributes:)
      {
        data: {
          type: @route,
          attributes: attributes
        }
      }
    end

    def uri
      @uri ||= URI::HTTPS.build host: host, path: "/api/v1/#{@route}"
    end

    def response_for(http_request, uri)
      Net::HTTP.start(uri.host, 443, use_ssl: true) do |http|
        http.request http_request
      end
    rescue *ConnectionError.errors => e
      raise ConnectionError, e.message
    end

    def assign_headers(request)
      headers.each_key do |header|
        request[header] = headers[header]
      end
      request
    end

    def headers
      {"Authorization" => "Bearer #{ENV['HUBBLE_APP_TOKEN']}",
       "Content-Type" => "application/vnd.api+json"}
    end

    def host
      subdomain = ENV['HUBBLE_ENV'] == 'production' ? 'hubble' : 'rc-hubble'
      "#{subdomain}.fullscreen.net"
    end
  end
end
