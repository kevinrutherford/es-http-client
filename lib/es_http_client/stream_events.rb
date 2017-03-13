require_relative './page'

module EsHttpClient

  class StreamEvents

    def initialize(name, connection)
      @connection = connection
      @latest_ref = Ref.head_of(name)
    end

    def each(&block)
      page = read_stream_page(@latest_ref.uri)
      last = page.last
      page = read_stream_page(last) if last
      loop do
        break unless page.has_entries?
        page.each_event(&block)
        next_page = page.previous
        break unless next_page
        page = read_stream_page(next_page)
      end
      return @latest_ref
    end

    private

    def read_stream_page(uri)
      response = @connection.get(uri, @latest_ref.etag)
      @latest_ref = Ref.new(uri, response.headers['etag'])
      Page.new(response.body)
    end

    def find_link(links, rel)
      link = links.detect { |l| l['relation'] == rel }
      link.nil? ? nil : link['uri']
    end

  end

end
