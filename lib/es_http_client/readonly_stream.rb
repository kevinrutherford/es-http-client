require_relative './stream_events'
require_relative './caught_up_stream'
require_relative './event'
require_relative './ref'

module EsHttpClient

  class ReadonlyStream

    def initialize(stream_name, connection)
      @stream_name = stream_name
      @connection = connection
    end

    def replay_forward(&block)
      ref = StreamEvents.new(@stream_name, @connection).each(&block)
      CaughtUpStream.new(ref, @connection)
    end

  end

end
