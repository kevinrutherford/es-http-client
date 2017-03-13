require 'faraday'
require 'faraday_middleware'
require_relative './es_http_client_error'

module EsHttpClient

  class ErrorHandler < Faraday::Response::Middleware

    def on_complete(env)
      status = env[:status]
      raise EsHttpClientError.new(status, env[:reason_phrase]) if status >= 400
    end

  end
end
