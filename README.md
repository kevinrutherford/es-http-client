# es-http-client
A Ruby HTTP client for EventStore

## Installation

Install the gem

```
gem install es-http-client
```

Or add it to your Gemfile and run `bundle`.

``` ruby
gem 'es-http-client'
```

## Usage

Open a connection to EventStore:
```ruby
eventstore = EsHttpClient.connect('http://localhost:2113', 'admin', 'changeit')
```

Subscribe to `$all`:

``` ruby
stream = eventstore.all_events
stream = stream.replay_forward {|event| ... }
stream.subscribe {|event| ... }
```

Write to a stream:

```ruby
stream = eventstore.stream(:user, user_id)
return 404 unless stream.exists?
stream_version = -1
stream.replay_forward do |event|
  if event.type == 'UserAccountClosed'
    return [410, JSON.pretty_generate({
      errors: 'User account already closed'
    })]
  end
  stream_version = event.number
end
return [400, JSON.pretty_generate({
  errors: "Stream #{stream} unexpectedly empty"
})] if stream_version < 0
event = EsHttpClient.create_event('UserAccountClosed', { userId:  user_id })
stream.append(event, stream_version) ? 200 : 409
```
