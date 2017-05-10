module HubbleApiClient
  class TalentAccount
    attr_reader :data

    def initialize(data:)
      @data = data
    end

    def uuid
      data[:attributes][:uuid]
    end

    def self.create!(email:)
      account_data = create_uuid(email)
      process_account_data(account_data)
    end

    def self.update!(attributes:, hubble_uuid:)
      account_data = update_attributes(attributes, hubble_uuid)
      process_account_data(account_data)
    end

    private

    def self.get_uuid(email)
      parse API.get_request(route: "talent-accounts/search", query: URI.encode_www_form("email"=>email))
    end

    def self.create_uuid(email)
      body = serialize_attributes(attributes: {email: email}, resource_type: "talent-accounts")
      parse API.post_request(route: "talent-accounts", body: body)
    end

    def self.update_attributes(attributes, hubble_uuid)
      body = serialize_attributes(attributes: attributes, resource_type: "talent-accounts")
      parse API.put_request(route: "talent-accounts/#{hubble_uuid}", body: body)
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

    def self.process_account_data(account_data)
      if account_data[:errors].present?
        raise HubbleApiClientNotFound, "Error(s): #{account_data[:errors]}"
      else
        new data: account_data[:data]
      end
    end
  end
end
