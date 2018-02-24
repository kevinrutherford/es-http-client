require_relative './readonly_stream'
require_relative './writeable_stream'

module EsHttpClient

  class Client

    def initialize(connection)
      @connection = connection
    end

    def resource(id)
      WriteableStream.new(id, @connection)
    end

    def stream(type, id)
      resource("#{type}-#{id}")
    end

    def all_events
      @all ||= ReadonlyStream.new("$all", @connection)
    end

  end

end

