module EsHttpClient

  class EsHttpClientError < StandardError

    attr_reader :code

    def initialize(code, reason)
      @code = code
      super("#{code}: #{reason}")
    end

  end

end
