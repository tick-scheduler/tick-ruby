
## Installation

Include it in your Gemfile:

```ruby
gem 'tick-ruby'
```

## Configuration

Set your api token:

```ruby
Tick.api_key = 'YOUR_TOKEN'
```

## Usage

### Create a Job

#### Single Run Jobs

To schedule a single-run one-off job:

```ruby
Tick::Job.create(
  :at      => 1.day.from_now,
  :url     => 'https://www.example.com/callback/url',
  :payload => {'foo' => 'bar'}
)
```

#### Recurring Jobs

Scheduling recurring jobs is super easy too.

```ruby
callback_url = 'https://www.example.com/callback/url'

# Every hour
Tick::Job.create(
  :rule    => {'type' => 'hourly'},
  :url     => callback_url,
  :payload => {'foo' => 'bar'}
)

# Every 60 seconds
Tick::Job.create(
  :rule    => {'type' => 'minutely'}, 
  :url     => callback_url
  :payload => {'foo' => 'bar'}
)

# Every 30 seconds
Tick::Job.create(
  :rule    => {'type' => 'secondly', 'interval' => 30},
  :url     => callback_url,
  :payload => {'foo' => 'bar'}
)

# Daily, that ends in two weeks
Tick::Job.create(
  :rule    => {'type' => 'daily', 'until' => 2.weeks.from_now},
  :url     => callback_url,
  :payload => {'foo' => 'bar'}
)

# Daily, starting tomorrow
Tick::Job.create(
  :rule    => {'type' => 'daily', 'start_time' => 1.day.from_now},
  :url     => callback_url,
  :payload => {'foo' => 'bar'}
)
```

Then all you have to do is mount an endpoint to receive the webhook when the job runs:

```ruby
post '/callback/url' do
  post_body = JSON.parse(request.body.read)

  payload = post_body['payload']

  # schedule the job with your existing background queue
  MyJob.perform_async(payload)
  status 200
end
```

**NOTE: Callback endpoints must return a successful HTTP response code (20x), or the job run will be considered a failure.**

### Update a Job

```ruby
job = Tick::Job.create(
  at: 1.minute.from_now,
  url: 'http://example.com/hook'
  payload: {foo: 'bar'}
)

job.payload = {'foo' => 'bar', 'id' => 2}
job.save
```

### Cancel a Job

```ruby
job = Tick::Job.create(
  at: 1.minute.from_now,
  url: 'http://example.com/hook'
  payload: {foo: 'bar'}
)

job.cancel
```
