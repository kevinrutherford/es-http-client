module EsHttpClient

  class Ref < Struct.new(:uri, :etag)

    def self.head_of(stream_name)
      Ref.new("/streams/#{stream_name}", nil)
    end

  end

end
