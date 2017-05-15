module HubbleApiClient
  class TalentAccount
    def self.create(email:)
      body = serialize_attributes(attributes: {email: email}, resource_type: "talent-accounts")
      data = parse API.post_request(route: "talent-accounts", body: body)
      process_account_data(data)
    end

    def self.update(attributes:, hubble_uuid:)
      body = serialize_attributes(attributes: attributes, resource_type: "talent-accounts")
      data = parse API.put_request(route: "talent-accounts/#{hubble_uuid}", body: body)
      process_account_data(data)
    end

    private

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
      if !account_data[:errors].nil? || account_data[:data].nil?
        nil
      else
        account_data[:data][:id]
      end
    end
  end
end
