# Topsy

Simple Ruby wrapper for the [Topsy.com](http://topsy.com) Otter API. Topsy is a search engine powered by tweets.

## Installation

Topsy is hosted on Gemcutter, so:

    gem install gemcutter # if necessary
    gem tumble # if necessary
    sudo gem install topsy

## Usage

    # Fetch search results for the query "gemcutter"
    results = Topsy.search("gemcutter")
    
    # Fetch search counts for the query "gemcutter"
    counts = Topsy.search_count("gemcutter")
    counts.this_week
    => 19
    
Check the [full gem documentation](http://yardoc.org/docs/pengwynn-topsy) and [API docs](http://code.google.com/p/otterapi/wiki/Resources) for more info.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but
   bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 [Wynn Netherland](http://wynnnetherland.com). See LICENSE for details.
