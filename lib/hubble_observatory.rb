require "hubble_observatory/version"
require "hubble_observatory/configuration"
require "hubble_observatory/observatory"
require "hubble_observatory/connection/api"

module HubbleObservatory
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration if block_given?
  end
end
