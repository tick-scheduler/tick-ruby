require 'faraday'
require 'faraday_middleware'
require 'faraday_middleware-multi_json'
require 'hashie'
require 'faraday/request/basic_authentication'

module Tick
  autoload :Client,     'tick/client'
  autoload :Job,        'tick/job'

  class << self
    attr_accessor :api_key

    def client
      @client ||= Tick::Client.new
    end

    def client=(client)
      @client = client
    end
  end
end
