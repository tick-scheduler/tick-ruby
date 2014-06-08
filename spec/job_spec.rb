require 'spec_helper'

describe 'Job.create' do
  it 'creates a job and returns the properties' do
    VCR.use_cassette 'single job' do
      time = Time.new(2014, 6, 7, 12, 36, 11).utc
      url = 'http://example.com/blah'
      payload = {'foo' => 'bar'}
      job = Tick::Job.create(at: time, url: url, payload: payload)
      job.id.should_not be_nil
      Time.parse(job.at).to_i.should == time.to_i
      job.url.should == url
      job.payload.should == payload
    end
  end

  it 'creates a recurring job and returns the rule' do
    VCR.use_cassette 'recurring job creation' do
      t = Time.now.utc + 61
      url = 'http://example.com/blah'
      job = Tick::Job.create(start_time: t, rule: {type: 'daily'}, url: url)
      job.id.should_not be_nil
      job.url.should == url
    end
  end
end

describe 'Job#save' do
  it 'updates the job' do
    VCR.use_cassette 'update job' do
      params = single_job_params
      job = Tick::Job.create(params)
      job_id = job.id
      new_at = params['at'] + 20
      job.at = new_at
      job.save
      job.at.should == new_at
      job.id.should == job_id
    end
  end
end

describe 'Job#cancel' do
  it 'cancels the job' do
    VCR.use_cassette 'cancel job', record: :new_episodes do
      params = single_job_params
      job = Tick::Job.create(params)
      j = job.cancel
      j.state.should == 'cancelled'
    end
  end

  it 'raises an error when cancelling an unsaved job' do
    job = Tick::Job.new
    expect {
      job.cancel
    }.to raise_error 'Cannot cancel unsaved job'
  end
end

describe 'Job.find' do
  it 'returns a job when found' do
    VCR.use_cassette 'find job', record: :new_episodes do
      job = Tick::Job.create(single_job_params)
      found_job = Tick::Job.find(job.id)
      found_job.id.should == job.id
    end
  end
end
