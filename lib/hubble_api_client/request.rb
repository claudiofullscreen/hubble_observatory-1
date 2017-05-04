module HubbleApiClient
  class Request
    def self.get_uuid(email)
      parse Connection::API.get_request(route: "accounts-users", query: build_query({"email" => email}))
    end

    def self.create_uuid(email)
      body = serialize_attributes(attributes: {email: email}, resource_type: "accounts_users")
      parse Connection::API.post_request(route: "accounts-users", body: body)
    end

    private

    def self.build_query(params)
      params.map { |k, v| "#{k}=#{v}" }.join("&")
    end

    def self.serialize_attributes(attributes:, resource_type:)
      {
        data: {
          type: resource_type,
          attributes: attributes
        }
      }
    end

    def self.parse(response)
      if response.code == '200'
        JSON.parse response.body, symbolize_names: true
      else
        raise HubbleApiclientNotFound, "Error #{response.code}: #{response.body}"
      end
    end
  end
end
