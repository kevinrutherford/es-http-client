require 'es_http_client/ref'

RSpec.describe EsHttpClient::CaughtUpStream do
  let(:connection) { double }
  let(:base_uri) { random_word }
  let(:base_etag) { random_word }
  subject { EsHttpClient::CaughtUpStream.new(EsHttpClient::Ref.new(base_uri, base_etag), connection) }

  context 'when there are no events to read' do
    let(:empty_page) { FakeResponse.new({'etag' => base_etag}, {
        'links'=>[],
        'entries'=>[]
      })
    }

    before do
      allow(connection).to receive(:get).with(base_uri, base_etag).and_return(empty_page)
    end

    example '#fetch yields no events' do
      next_ref = subject.fetch(EsHttpClient::Ref.new(base_uri, base_etag)) { expect(self).to eq(nil) }
      expect(next_ref).to eq(EsHttpClient::Ref.new(base_uri, base_etag))
    end

  end

  context 'when there are events to read' do
    let(:previous) { random_word }
    let(:next_etag) { random_word }
    let(:page_with_events) { FakeResponse.new({'etag' => next_etag}, {
        'links'=>[{'uri' => previous, 'relation' => 'previous'}],
        'entries'=>[{'type' => 'boo', 'data' => '{}'},{'type' => 'boo', 'data' => '{}'}]
      })
    }

    before do
      allow(connection).to receive(:get).with(base_uri, base_etag).and_return(page_with_events)
    end

    example '#fetch yields the events' do
      count = 0
      next_ref = subject.fetch(EsHttpClient::Ref.new(base_uri, base_etag)) { count += 1 }
      expect(next_ref).to eq(EsHttpClient::Ref.new(previous, next_etag))
      expect(count).to eq(2)
    end

  end

end
