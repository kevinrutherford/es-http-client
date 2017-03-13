require_relative './readonly_stream'
require_relative './writeable_stream'

module EsHttpClient

  class Client

    def initialize(connection)
      @connection = connection
    end

    def stream(type, id)
      WriteableStream.new("#{type}-#{id}", @connection)
    end

    def all_events
      @all ||= ReadonlyStream.new("$all", @connection)
    end

  end

end
