require 'spec_helper'

describe 'updating a recurring job' do
  example do
    VCR.use_cassette 'updating a recurring job' do
      job = Tick::Job.create(rule: {'type' => 'daily'}, url: 'http://example.com/hook')
      job.rule['type'].should == 'daily'
      job.rule = {'type' => 'hourly'}
      job.save
      job.rule['type'].should == 'hourly'
    end
  end
end
