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

    # coding: utf-8
    require 'langue-japanese'

    # Get a language class
    language = Langue['japanese'].new

    # Split to morphemes a text
    morphemes = language.parse('今日は妹と一緒にお買い物してきたよ。楽しかった〜')

    # Create a structured text from the morphemes
    text = language.structure(morphemes)

    # When using English
    require 'langue-english'

    other_language = Langue['english'].new

If tiresome to require gem for each language, you will write the code following
instead:

    require 'langue/all'

Contributing
------------

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
