# HubbleObservatory

HubbleObservatory is a Ruby library to make it easy to interact with the Hubble API.

## Installation and Configuration

Add this line to your application's Gemfile:

```ruby
gem 'hubble_observatory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubble_observatory


HubbleObservatory requires a HUBBLE_APP_TOKEN which you can obtain from https://hubble.fullscreen.net.

1. Set the following ENV variables in your Ruby/Rails application

    ```ruby
      ENV['HUBBLE_APP_TOKEN'] = hubble_app_token_given_to_you
      ENV['HUBBLE_ENV'] = "production"
    ```

Note: If you set `ENV['HUBBLE_ENV']` to any value other than
`production`, you will hit the staging Hubble API

### Talents API Overview

#### Use #create to create a new unique Hubble uuid associated with an email

```ruby
talent_account = HubbleObservatory::TalentAccount.create(email: "someone@fullscreen.com")
# => '123456'
```

#### Use #update to update an email with an already assigned Hubble uuid

```ruby
talent_account = HubbleObservatory::TalentAccount.new(id: '123456').update(email:
"update_someone@fullscreen.com")
# => '123456'
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

To run the test suite:

```ruby
HUBBLE_APP_TOKEN=<token> bundle exec rake
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hubble_observatory.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

