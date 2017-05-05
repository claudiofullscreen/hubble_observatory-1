module HubbleApiClient
  class TalentAccount
    attr_reader :data

    def initialize(data:)
      @data = data
    end

    def uuid
      data[:attributes][:uuid]
    end

    def self.find_or_create_by!(email:, id:)
      @email = email
      @id = id
      account_data = create_uuid
      account_data = get_uuid if account_data[:errors].present?
      raise HubbleApiClientNotFound, "Error(s): #{account_data[:errors]}" if account_data[:errors].present?
      new data: account_data[:data]
    end


    private

    def self.get_uuid
      parse Connection::API.get_request(route: "talent-accounts", query: build_query({"email" => @email, "id" => @id}))
    end

    def self.create_uuid
      body = serialize_attributes(attributes: {email: @email, id: @id}, resource_type: "talent-accounts")
      parse Connection::API.post_request(route: "talent-accounts", body: body)
    end

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
      data_response = JSON.parse response.body, symbolize_names: true
    end
  end
end
