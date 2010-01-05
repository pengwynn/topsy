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
      
      results.total.should == 1004
      results.list.first.content.should == 'For auld lang syne, my dear: http://en.wikipedia.org/wiki/Auld_Lang_Syne#Lyrics'
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
      results.total.should == 1
      results.list.first.influence_level.should == 10
    end
    
    should "return a list of URLs related to a given URL" do
      stub_get("/related.json?url=http%3A%2F%2Fgemcutter.org", "related.json")
      results = Topsy.related("http://gemcutter.org")
      results.total.should == 17
      results.list.first.title.should == 'the update | gemcutter | awesome gem hosting'
    end
    
    should "return a list of results for a query" do
      stub_get("/search.json?q=NYE", "search.json")
      results = Topsy.search("NYE")
      results.total.should == 117731
      results.list.first.score.should == 4.70643044
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
