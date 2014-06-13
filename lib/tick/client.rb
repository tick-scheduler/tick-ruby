require 'tick/version'

module Tick
  class Client
    DEFAULT_OPTS = {
      :host       => 'https://api.tickscheduler.com',
      :ssl => {
        :verify => true
      }
    }

    def initialize(opts = {})
      @opts = DEFAULT_OPTS.merge(opts)
    end

    def connection
      raise "You must set Tick.api_key before issuing requests" unless Tick.api_key
      @connection ||= begin
        Faraday.new(@opts[:host]) do |conn|
          conn.request :multi_json
          conn.request :basic_auth, Tick.api_key, ''
          conn.response :multi_json
          conn.response :raise_error

          conn.headers['User-Agent'] = "tick-ruby/#{Tick::VERSION}"

          conn.adapter Faraday.default_adapter
        end
      end
    end

    def get(url, opts = {})
      connection.get(url, opts)
    end

    def post(url, opts = {})
      connection.post(url, opts)
    end

    def put(url, opts = {})
      connection.put(url, opts)
    end

    def delete(url, opts = {})
      connection.delete(url)
    end
  end
end
