# Pact::Csv

Provides CSV support for the Pact gem.

## Installation

Add this line to your application's Gemfile:

    gem 'pact-csv'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pact-csv

## Usage

```ruby
require 'pact'
require 'pact/csv'

Pact.configure do | config |
    
    # Maybe do this automatically?
    config.register_body_differ /csv/, Pact::CSV::Differ
    config.register_diff_formatter /csv/, Pact::CSV::DiffFormatter

end

```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pact-csv/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
