# Topsy

Simple Ruby wrapper for the [Topsy.com](http://topsy.com) Otter API. Topsy is a search engine powered by tweets.

## Installation

Topsy is hosted on Gemcutter, so:

    gem install gemcutter # if necessary
    gem tumble # if necessary
    sudo gem install topsy

## Usage
    >> Topsy.rate_limit
    => <#Topsy::RateLimitInfo limit=10000 remaining=10000 reset=1262804400>

    >> Topsy.author_info('http://twitter.com/barackobama')
    => <#Topsy::Author description="44th President of the United States" influence_level=10 name="Barack Obama" nick="barackobama" topsy_author_url="http://topsy.com/twitter/barackobama" type="twitter" url="http://twitter.com/barackobama">

    >> Topsy.author_search('programming')
    => <#Topsy::Page list=[<#Topsy::Author descript ... ] page=1 perpage=15 topsy_trackback_url=nil total=97229 window=nil>
    
    >> Topsy.author_search('programming', :perpage => 2, :page => 1)
    => <#Topsy::Page list=[<#Topsy::Author description="Most ... ] page=1 perpage=2 topsy_trackback_url=nil total=100685 window=nil>
    
    >> Topsy.link_posts('http://twitter.com/barackobama', :perpage => 2, :page => 2)
    => <#Topsy::Page list=[<#Topsy::Linkpost content="An important reminder ... ] page=2 perpage=2 topsy_trackback_url=nil total=402 window=nil>

    >> Topsy.link_posts('http://twitter.com/barackobama')
    => <#Topsy::Page list=[<#Topsy::Linkpost content="An important reminder about health reform on the @Whit... ] page=1 perpage=10 topsy_trackback_url=nil total=402 window=nil>
    
    >> Topsy.link_post_count('http://twitter.com/barackobama')
    => <#Topsy::LinkpostCount all=402 contains=0>

    >> Topsy.url_info('http://etagwerker.com')
    => <#Topsy::UrlInfo description="" description_attribution="" oneforty="just finished installing wordpress in a linux .." url="http://etagwerker.com/"> 
    
    >> Topsy.stats('http://www.google.com')
    => <#Topsy::Stats all=29869 contains=0 influential=2023 topsy_trackback_url="http://topsy.com/tb/www.google.com/">

    >> Topsy.search('rock')
    => <#Topsy::Page list=[<#Topsy::LinkSearchResult content="Why 30 Rock is a Rip-Off of The Muppet Show - http://is.gd/15KJZ" .. ]  page=1 perpage=10 topsy_trackback_url=nil total=714429 window="a"> 
    
    >> Topsy.search('rock', :perpage => 2, :page => 3)
    => <#Topsy::Page list=[<#Topsy::LinkSearchResult content="Just released! Beatles Rock Band opening cinematic. Amaz ..." ] page=3 perpage=2 topsy_trackback_url=nil total=714429 window="a">
    
    >> Topsy.search('rock', :perpage => 2, :page => 3, :window => 'd')
    => <#Topsy::Page list=[<#Topsy::LinkSearchResult content="Be a Google Wave Rock Star http://ff.im/-dPdGL" highlight="Be a .. "] page=3 perpage=2 topsy_trackback_url=nil total=6064 window="d">
    
    >> Topsy.search_count('rock')
    => <#Topsy::SearchCounts a=5191790 d=7601 h=206 m=216179 w=45462>
    
    >> Topsy.profile_search('Hacker+Rubyist')
    => <#Topsy::Page list=[<#Topsy::Author description="Hacker; Rubyist; Bit Poet" influence_level=4 name="Ben Bleythi ...">] page=1 perpage=10 topsy_trackback_url=nil total=5 window=nil>
     
    >> Topsy.profile_search('Hacker+Rubyist', :perpage => 1, :page => 2)
    => <#Topsy::Page list=[<#Topsy::Author description="Rubyist, hacker, gamer (video, board and role-playing)... ">] page=2 perpage=1 topsy_trackback_url=nil total=5 window=nil>
    
    >> Topsy.related('http://www.twitter.com')
    => <#Topsy::Page list=[<#Topsy::LinkSearchResult title="New Twitter Feature: Body Counts | Danger Room ... ">] page=1 perpage=10 topsy_trackback_url=nil total=4458 window=nil>
     
    >> Topsy.tags('http://twitter.com')
    => <#Topsy::Page list=[<#Topsy::Tag name="current" url="http://topsy.com/s?q=current">, <#Topsy::Tag name="twe ... ">] page=1 perpage=10 topsy_trackback_url=nil total=1885 window=nil>
    
    >> Topsy.trending
    => <#Topsy::Page list=[<#Topsy::Trend term="u s reopens embassy in yemen" url="http://topsy.com/s?q=u+s%20r ... ">] page=1 perpage=10 topsy_trackback_url=nil total=1434 window=nil>
    
    >> Topsy.trending(:page => 3, :perpage => 2)
    => <#Topsy::Page list=[<#Topsy::Trend term="droid vs iphone" url="http://topsy.com/s?q=droid+vs%20iphone" ... ">] page=3 perpage=2 topsy_trackback_url=nil total=1434 window=nil>

    >> Topsy.trackbacks('http://twitter.com', :perpage => 2, :page => 2)
    => <#Topsy::Page list=[<#Topsy::Tweet author=<#Topsy::Author influence_level=8 name="tama" photo_url="http://a3.twimg .. ">] page=2 perpage=2 topsy_trackback_url="http://topsy.com/tb/twitter.com/" total=39705 window=nil>
    
    >> Topsy.trackbacks('http://twitter.com', :perpage => 2, :page => 2, :contains => 'mashable')
    => <#Topsy::Page list=[<#Topsy::Tweet author=<#Topsy::Author name="Hannah Grosvenor" photo_url="http://a1.t. ... >] page=2 perpage=2 topsy_trackback_url="http://topsy.com/tb/twitter.com/" total=41 window=nil>
    
    # Fetch search results for the query "gemcutter"
    >> results = Topsy.search("gemcutter")
    => <#Topsy::Page list=[<#Topsy::LinkSearchResult content="New design ... ]>
    
    # Fetch search counts for the query "gemcutter"
    >> counts = Topsy.search_count("gemcutter")
    => <#Topsy::SearchCounts a=773 d=6 h=0 m=103 w=24>
    >> counts.this_week
    => 24
    
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
