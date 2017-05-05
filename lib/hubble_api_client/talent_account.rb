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
      account_data = account_data[:errors].present? ? get_uuid : account_data
      if account_data[:errors].present?
        raise HubbleApiClientNotFound, "Error(s): #{account_data[:errors]}"
      else
        new data: account_data[:data]
      end
    end


    private

    def self.get_uuid
      parse API.get_request(route: "talent-accounts", query: URI.encode_www_form("email"=>@email, "gorilla_id" => @gorilla_id))
    end

    def self.create_uuid
      body = serialize_attributes(attributes: {email: @email, gorilla_id: @gorilla_id}, resource_type: "talent-accounts")
      parse API.post_request(route: "talent-accounts", body: body)
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
