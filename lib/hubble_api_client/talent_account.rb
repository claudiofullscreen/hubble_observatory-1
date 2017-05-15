module HubbleApiClient
  class TalentAccount
    attr_reader :hubble_uuid

    def initialize(id:)
      @hubble_uuid = id
    end

    def self.create(email:)
      body = serialize_attributes(attributes: {email: email})
      data = parse process_request(route: "talent-accounts", body: body, request_type: "post")
      process_account_data(data)
    end

    def update(email:)
      body = self.class.serialize_attributes(attributes: {email: email})
      data = self.class.parse self.class.process_request(route: "talent-accounts/#{hubble_uuid}", body: body, request_type: "put")
      self.class.process_account_data(data)
    end

    private

    def self.serialize_attributes(attributes:)
      {
        data: {
          type: "talent-accounts",
          attributes: attributes
        }
      }
    end

    def self.parse(response)
      data_response = JSON.parse response.body, symbolize_names: true
    end

    def self.process_account_data(account_data)
      if !account_data[:errors].nil? || account_data[:data].nil?
        nil
      else
        account_data[:data][:id]
      end
    end

    def self.process_request(route:, body:, request_type:)
      uri = URI::HTTPS.build host: host.fetch(ENV['HUBBLE_ENV'], 'localhost:3000'),
        path: "/api/v1/#{route}"
      net_http_class = Object.const_get("Net::HTTP::#{request_type.capitalize}")
      request = net_http_class.new uri
      request.body = body.to_json
      response_for(assign_headers(request), uri)
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

    def self.host
      {"production" => "hubble.fullscreen.net",
       "staging" => "stage-hubble.fullscreen.net"}
    end

    def self.headers
      {"Authorization" => "Bearer #{ENV['HUBBLE_APP_TOKEN']}",
       "Content-Type" => "application/vnd.api+json"}
    end
  end
end
