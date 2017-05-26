# Hubble Observatory

Hubble Observatory is a Ruby library to interact with the Hubble API.

## Installation and Configuration

Add this line to your application’s Gemfile:

```ruby
gem 'hubble_observatory'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hubble_observatory

Set the following ENV variables in your Ruby/Rails application

```ruby
ENV['HUBBLE_APP_TOKEN'] = "<app token to access Hubble API>"
ENV['HUBBLE_ENV'] = "production"
```

If you don’t set `ENV['HUBBLE_ENV']` to "production", the staging Hubble API will be targeted.

## How to use

Hubble Observatory provide only two methods to create and update talent accounts.

### TalentAccount.create

Obtain the ID of Talent Account given the corresponding email:

```ruby
talent_account = HubbleObservatory::TalentAccount.create email: 'user@example.com'
# => '123456'
```

### TalentAccount#update

Update the email of a Talent Account give the corresponding ID:

```ruby
talent_account = HubbleObservatory::TalentAccount.new id: '123456'
talent_account.update email: 'newuser@example.com'
# => '123456'
```

## How to develop and contribute

To install the app and its dependencies, run `bin/setup`.

To execute the test suite, run:

```ruby
HUBBLE_APP_TOKEN=<token> bundle exec rake
```

To release a new version, run: `bundle exec rake release`.
