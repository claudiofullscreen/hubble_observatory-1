module HubbleApiClient
  class Request
    def self.get_hubble_uuid(email)
      parse Connection::API.get_request(route: "hubble_uuid", query: build_query({"email" => email}))
    end

    def self.create_hubble_uuid(email)
      parse Connection::API.post_request(route: "hubble_uuid", body: build_query({"email" => email}))
    end

    def build_query(params)
      params.map { |k, v| "#{k}=#{v}" }.join("&")
    end

    private

    def self.parse(response)
      if response.code == '200'
        JSON.parse response.body, symbolize_names: true
      else
        raise HubbleApiclientNotFound, "Error #{response.code}: #{response.body}"
      end
    end
  end
end
