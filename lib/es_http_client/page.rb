module EsHttpClient

  class Page

    def initialize(body)
      @body = body
    end

    def last
      find_link('last')
    end

    def previous
      find_link('previous')
    end

    def has_entries?
      @body['entries'] && @body['entries'].length > 0
    end

    def each_event(&block)
      @body['entries']
        .reverse!
        .map {|e| Event.load_from(e)}
        .compact
        .select {|e| e.type !~ /^\$/ }
        .each {|e| yield e }
    end

    private

    def find_link(rel)
      link = @body['links'].detect { |l| l['relation'] == rel }
      link.nil? ? nil : link['uri']
    end

  end

end
