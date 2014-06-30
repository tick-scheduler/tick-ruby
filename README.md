
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

```ruby
# Single run job
Tick::Job.create(
  at: 1.minute.from_now,
  url: 'http://example.com/hook',
  payload: {foo: 'bar'}
)

# Recurring daily job
Tick::Job.create(
  rule: {
    start_time: 1.hour.from_now,
    type: 'daily',
    until: 30.days.from_now
  },
  url: 'http://example.com/hook',
  payload: {foo: 'bar'}
)
```

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
