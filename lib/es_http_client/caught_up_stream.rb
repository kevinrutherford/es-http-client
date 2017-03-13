require_relative './event'
require_relative './page'

module EsHttpClient

  class CaughtUpStream

    def initialize(ref, connection)
      @ref = ref
      @connection = connection
    end

    def subscribe(&block)
      loop do
        sleep 1
        @ref = fetch(@ref, &block)
      end
    end

    def fetch(ref, &block)
      response = @connection.get(ref.uri, ref.etag)
      page = Page.new(response.body)
      next_uri = ref.uri
      if page.has_entries?
        page.each_event(&block)
        next_uri = page.previous
      end
      return Ref.new(next_uri, response.headers['etag'])
    end

  end
end
