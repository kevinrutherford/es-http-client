require_relative './stream_events'
require_relative './ref'

module EsHttpClient

  class WriteableStream

    def initialize(name, connection)
      @stream_name = name
      @connection = connection
    end

    def to_s
      @stream_name
    end

    def exists?
      ref = Ref.head_of(@stream_name)
      @connection.get(ref.uri, ref.etag)
      true
    rescue EsHttpClientError => e
      return false if e.code == 404
      raise e
    end

    def append(event, expected_version=ExpectedVersion::Any)
      @connection.post(Ref.head_of(@stream_name).uri, event, expected_version)
      true
    rescue EsHttpClientError => e
      STDERR.puts e.message
      false
    end

    def replay_forward(&block)
      StreamEvents.new(@stream_name, @connection).each(&block)
    end

  end

end

