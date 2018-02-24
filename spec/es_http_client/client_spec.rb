require 'es_http_client/stream_events'
require 'es_http_client/ref'

RSpec.describe EsHttpClient::Client do
  let(:connection) { double('Connection') }
  subject { EsHttpClient::Client.new(connection) }

  context 'when opening a writeable stream' do

    example 'the stream has the correct name' do
      stream = subject.stream(:type, 'id')
      expect(stream.to_s).to eq('type-id')
    end
  end

  context 'when opening a writeable resource' do

    example 'the stream has the correct name' do
      resource = subject.resource('type-id')
      expect(resource.to_s).to eq('type-id')
    end
  end

end

