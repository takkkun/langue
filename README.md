What is langue
==============

It is the foundation to provide the operations to the natural languages.

Installation
------------

Add this line to your application's Gemfile:

    gem 'langue'

    # When using Japanese
    gem 'langue-japanese'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install langue
    $ gem install langue-japanese

Usage
-----

    require 'langue'
    require 'langue-japanese'

    language = Langue['japanese']

    # Get a tokenizer for Japanese
    tokenizer = language.create_tokenizer(tokenizer_options)

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
