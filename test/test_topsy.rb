require 'helper'

class TestTopsy < Test::Unit::TestCase
  
  context "when hitting the Otter API" do
    
    should "return author info for a profile url" do
      stub_get("/authorinfo.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", "authorinfo.json")
      info = Topsy.author_info("http://twitter.com/pengwynn")
      info.class.should == Topsy::Author
      info.nick.should == 'pengwynn'
      info.influence_level.should == 10
      assert info.description.include? "Ruby"
      info.name.should == "Wynn Netherland"
      info.url.should == "http://twitter.com/pengwynn"
      info.topsy_author_url.should == "http://topsy.com/twitter/pengwynn"
      # info.type.should == 'twitter' this will throw 'warning: Object#type is deprecated; use Object#class' - 
      # maybe we should use an alias, topsy_type? 
    end
    
    should "return search for authors" do
      stub_get("/authorsearch.json?q=pengwynn", "authorsearch.json")
      results = Topsy.author_search("pengwynn")
      results.class.should == Topsy::Page
      results.total.should == 491
      results.list.first.class.should == Topsy::Author
      results.list.first.nick.should == 'bradleyjoyce'
    end
    
    should "list of urls posted by an author" do
      stub_get("/linkposts.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", "linkposts.json")
      results = Topsy.link_posts("http://twitter.com/pengwynn")
      results.class.should == Topsy::Page
      results.total.should == 1004
      results.list.first.class.should == Topsy::Linkpost
      results.list.first.content.should == 'For auld lang syne, my dear: http://en.wikipedia.org/wiki/Auld_Lang_Syne#Lyrics'
      results.list.first.permalink_url.should == 'http://twitter.com/pengwynn/status/7253938349'
      results.list.first.target.class.should == Topsy::Target
      results.list.first.date.should == 1262307998
      results.list.first.date_alpha.should == '16 hours ago'
    end
    
    should "return count of links posted by an author" do
      stub_get("/linkpostcount.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", "linkpostcount.json")
      counts = Topsy.link_post_count("http://twitter.com/pengwynn")
      counts.class.should == Topsy::LinkpostCount
      counts.all.should == 1004
      counts.contains.should == 0
    end
    
    should "return a list of author profiles that match the query." do
      stub_get("/profilesearch.json?q=pengwynn", "profilesearch.json")
      results = Topsy.profile_search("pengwynn")
      results.class.should == Topsy::Page
      results.total.should == 1
      results.list.first.class.should == Topsy::Author
      results.list.first.influence_level.should == 10
    end
    
    should "return a list of URLs related to a given URL" do
      stub_get("/related.json?url=http%3A%2F%2Fgemcutter.org", "related.json")
      results = Topsy.related("http://gemcutter.org")
      results.class.should == Topsy::Page
      results.total.should == 17
      results.list.first.class.should == Topsy::LinkSearchResult
      results.list.first.title.should == 'the update | gemcutter | awesome gem hosting'
      results.list.first.trackback_total.should == 17
      results.list.first.topsy_trackback_url.should == "http://topsy.com/tb/update.gemcutter.org/"
      results.list.first.url.should == "http://update.gemcutter.org/"
    end
    
    should "return a list of results for a query" do
      stub_get("/search.json?q=NYE", "search.json")
      results = Topsy.search("NYE")
      results.class.should == Topsy::Page
      results.total.should == 117731
      results.page.should == 1
      results.perpage.should == 10
      results.window.should == "a"
      results.list.first.class.should == Topsy::LinkSearchResult
      results.list.first.score.should == 4.70643044
      results.list.first.trackback_permalink.should == "http://twitter.com/spin/status/5164154014"
      results.list.first.hits.should == 397
      results.list.first.trackback_total.should == 2268
      results.list.first.topsy_trackback_url.should == "http://topsy.com/trackback?url=http%3A%2F%2Fwww.youtube.com%2Fwatch%3Fv%3DXGK84Poeynk"
      results.list.first.url.should == "http://www.youtube.com/watch?v=XGK84Poeynk"
      results.list.first.content.should == "Science, autotuned, with Sagan, Bill Nye, Tyson, Feynman http://bit.ly/2tDk4y win!"
      results.list.first.title.should == "YouTube - Symphony of Science - 'We Are All Connected' (ft. Sagan, Feynman, deGrasse Tyson & Bill Nye)"
      results.list.first.highlight.should == "Science, autotuned, with Sagan, Bill <span class=\"highlight-term\">Nye</span>, Tyson, Feynman http://bit.ly/2tDk4y win! " 
    end

    should "return search counts for a term" do
      stub_get("/searchcount.json?q=Balloon%20Boy", "searchcount.json")
      counts = Topsy.search_count('Balloon Boy')
      counts.last_hour.should == 0
      counts.last_month.should == 3659
      counts.all_time.should == 42289
    end
    
    should "return count of tweets for a url" do
      stub_get("/stats.json?url=http%3A%2F%2Fgithub.com%2Fpengwynn%2Flinkedin", "stats.json")
      stats = Topsy.stats("http://github.com/pengwynn/linkedin")
      stats.all.should == 11
      stats.influential.should == 3
    end
    
    should "return a list of tags associated with a url" do
      stub_get("/tags.json?url=http%3A%2F%2Fgemcutter.org", "tags.json")
      results = Topsy.tags("http://gemcutter.org")
      results.total.should == 9
      assert results.list.map{|t| t.name}.include?("ruby")
    end
    
    should "return a list of tweets (trackbacks) that mention the query URL" do
      stub_get("/trackbacks.json?url=http%3A%2F%2Forrka.com", "trackbacks.json")
      results = Topsy.trackbacks("http://orrka.com")
      results.total.should == 3
      results.list.first.date.year.should == 2009
    end
    
    should "return a list of trending terms" do
      stub_get("/trending.json", "trending.json")
      results = Topsy.trending
      results.total.should == 1379
      assert results.list.map{|t| t.term}.flatten.include?("auld lang syne")
    end
    
    should "return info about a url" do
      stub_get("/urlinfo.json?url=http%3A%2F%2Fwynnnetherland.com", 'urlinfo.json')
      results = Topsy.url_info('http://wynnnetherland.com')
      results.trackback_total.should == 39379
    end
  end
  
end
