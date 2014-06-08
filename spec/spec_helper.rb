require 'rubygems'

require 'rspec'
require 'vcr'

$:.unshift(File.dirname(File.expand_path(__FILE__)))

require File.join(File.dirname(File.expand_path(__FILE__)), "..", "lib", "tick")

Dir['spec/models/*'].each { |f| require File.expand_path(f) }

Tick.api_key = 's3R5xRCE7AXwJDorqXzLBUydJJxrez3iSqWHyLmBf98r'

RSpec.configure do |c|
  def job_params(params = {})
    {
      'url' => 'http://example.com/hook',
      'payload' => {'foo' => 'bar'}
    }.merge(params)
  end

  def single_job_params(params = {})
    t = Time.new(2014, 6, 7, 12, 37, rand(59))
    job_params('at' => t)
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end
