module HubbleObservatory
  # Provides methods to interact with the Hubble API fs-employees endpoint
  # @see https://hubble.fullscreen.net/api/docs#fsemployees-getting-jwt-token
  class Employee
    # @return [String] the token associated with the employee
    def self.create(access_token:)
      request = HubbleObservatory::Request.new(attrs: {route: 'fs-employees/jwt-token', params: {access_token: access_token}})
      response = request.run_request
      require 'pry'; binding.pry; true;
      data = request.parse response
      if data[:data]
        data[:data][:attributes][:jwt_token]
      end
    end
  end
end
