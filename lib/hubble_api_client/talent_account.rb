module HubbleApiClient
  class TalentAccount
    def self.get_uuid(email:, id:)
      parse Connection::API.get_request(route: "talent-accounts", query: build_query({"email" => email, "id" => id}))
    end

    def self.create_uuid(email:, id:)
      body = serialize_attributes(attributes: {email: email, id: id}, resource_type: "talent-accounts")
      parse Connection::API.post_request(route: "talent-accounts", body: body)
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
        raise HubbleApiClientNotFound, "Error #{response.code}: #{response.body}"
      end
    end
  end
end
