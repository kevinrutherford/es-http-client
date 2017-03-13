require 'faraday'
require 'faraday_middleware'
require 'json'
require 'base64'
require_relative './error_handler'

module EsHttpClient

  class Connection

    def initialize(endpoint, username=nil, password=nil)
      STDERR.puts "Faraday connecting to #{endpoint}"
      @connection = Faraday.new(url: endpoint) do |faraday|
        faraday.request :retry, max: 4, interval: 0.05, interval_randomness: 0.5, backoff_factor: 2
        faraday.response :json, content_type: 'application/json'
        faraday.response :mashify
        faraday.adapter Faraday.default_adapter
        faraday.use ErrorHandler
      end
      @headers = {
        'Accept'       => 'application/json',
        'Content-Type' => 'application/json'
      }
      if username && password
        token = Base64.encode64("#{username}:#{password}")[0..-2]
        @headers.merge!({ 'Authorization' => "Basic #{token}" })
      end
    end

    def get(uri, etag)
      response = @connection.send(:get, uri) do |req|
        req.headers = @headers
        req.headers.merge({ 'If-None-Match' => etag, 'ES-LongPoll' => 10 }) if etag
        req.body = {}.to_json
        req.params['embed'] = 'body'
      end
      response
    rescue EsHttpClientError => e
      STDERR.puts "Faraday: Error response #{e}"
      raise e
    end

    def post(uri, event, expected_version)
      @connection.send(:post, uri) do |req|
        req.headers = {
          'Accept'        => 'application/json',
          'Content-Type'  => 'application/json',
          'ES-EventType' => event.type,
          'ES-EventId'   => event.id,
          'ES-ExpectedVersion' => expected_version.to_s
        }
        req.body = event.data.to_json
      end
    end

  end

end
