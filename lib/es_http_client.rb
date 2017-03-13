require 'uuidtools'
require_relative './es_http_client/client'
require_relative './es_http_client/connection'
require_relative './es_http_client/es_http_client_error'

module EsHttpClient

  module ExpectedVersion
    Any         = -2
    NoStream    = -1
    EmptyStream = -1
  end

  def self.connect(endpoint, username, password)
    Client.new(Connection.new(endpoint, username, password))
  end

  def self.create_event(type, data)
    id = UUIDTools::UUID.random_create.to_s
    timestamp = Time.now.strftime('%FT%T.%3N%:z')
    data = data.merge({
      occurredAt: timestamp
    })
    Event.new(id, type, data, timestamp, 0)
  end

end
