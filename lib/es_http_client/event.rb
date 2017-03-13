module EsHttpClient

  class Event < Struct.new(:id, :type, :data, :updated, :number, :uri, :stream_id)

    def self.load_from(hash)
      return nil unless hash['data']
      data = JSON.parse(hash['data'], symbolize_names: true)
      event = Event.new(hash['eventId'], hash['eventType'], data, hash['updated'], hash['eventNumber'].to_i, hash['id'], hash['streamId'])
      event
    end

    def occurred_at
      data[:occurredAt]
    end

    private

    def initialize(id, type, data, updated=nil, number=nil, uri=nil, stream_id=nil)
      super
    end

  end

end
