# An object-oriented client for the Hubble API
module HubbleApiClient
  # Documents the connection errors that can occur
  class ConnectionError < StandardError
    # Possible list of connection errors that can occur
    ERRORS = [
        OpenSSL::SSL::SSLError,
        Errno::ETIMEDOUT,
        Errno::EHOSTUNREACH,
        Errno::ENETUNREACH,
        Errno::ECONNRESET,
        Net::OpenTimeout,
        SocketError
      ]
  end
end
