require 'helper'

class TestTopsy < Test::Unit::TestCase
  
  context "when hitting the Otter API" do
    
    should "return rate limit information when calling credit" do
      stub_get("/credit.json", "credit.json")
      Topsy.rate_limit.limit.should == 10000
      Topsy.rate_limit.remaining.should == 9998
      Topsy.rate_limit.reset.should == Time.at(1262707200)
    end
    
    should "return rate limit information with every request" do

      # FakeWeb.register_uri(:get, "http://otter.topsy.com/authorinfo.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", headers)
      stub_get("/authorinfo.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", "authorinfo.json")
      
      info = Topsy.author_info("http://twitter.com/pengwynn")
      
      Topsy.rate_limit.limit.should == 10000
      Topsy.rate_limit.remaining.should == 9998
      Topsy.rate_limit.reset.should == Time.at(1262707200)
    end
    
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
      info.type.should == 'twitter' 
    end
    
    should "return a page with a list of authors for the search" do
      stub_get("/experts.json?q=pengwynn", "experts.json")
      results = Topsy.experts("pengwynn")
      results.class.should == Topsy::Page
      results.total.should == 491
      results.list.first.class.should == Topsy::Author
      results.list.first.nick.should == 'bradleyjoyce'
    end
    
    should "return the second page of an author search with a list of 10 authors" do
      stub_get("/experts.json?q=pengwynn&page=2&perpage=10", "experts-page2.json")
      results = Topsy.experts("pengwynn", :page => 2, :perpage => 10)
      results.class.should == Topsy::Page
      results.total.should == 512
      results.perpage.should == 10
      results.page.should == 2
      results.list.size.should == 10
    end
    
    should "return a page with a list of urls posted by an author" do
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
    
    should "return the second page of 10 urls posted by an author" do
      stub_get("/linkposts.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn&page=2&perpage=5", "linkposts-page2.json")
      results = Topsy.link_posts("http://twitter.com/pengwynn", :page => 2, :perpage => 5)
      results.total.should == 987
      results.perpage.should == 5
      results.page.should == 2
      results.list.size.should == 5
    end
    
    should "return count of links posted by an author" do
      stub_get("/linkpostcount.json?url=http%3A%2F%2Ftwitter.com%2Fpengwynn", "linkpostcount.json")
      counts = Topsy.link_post_count("http://twitter.com/pengwynn")
      counts.class.should == Topsy::LinkpostCount
      counts.all.should == 1004
      counts.contains.should == 0
    end
        
    should "return a page with a list of URLs related to a given URL" do
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
    
    context "when searching" do
      
      should "handle string queries" do
        stub_get("/search.json?q=NYE&window=m", "search.json")
        results = Topsy.search("NYE", :window => :month)
      end
      
      should "handle hash queries" do
        stub_get("/search.json?q=site%3Athechangelog.com&window=h", "search.json")
        results = Topsy.search(:site => 'thechangelog.com', :window => :hour)
      end
      
      should "handle hash queries with explicit window" do
        stub_get("/search.json?q=site%3Athechangelog.com&window=h3", "search.json")
        results = Topsy.search(:site => 'thechangelog.com', :window => 'h3')
      end
      
      should "handle hash queries with explicit window with undefined terms" do
        stub_get("/search.json?q=site%3Athechangelog.com&window=dynamic", "search.json")
        results = Topsy.search(:site => 'thechangelog.com', :window => :dynamic)
      end
      
      should "handle combined queries" do
        stub_get("/search.json?q=riak%20site%3Athechangelog.com&window=h", "search.json")
        results = Topsy.search('riak', :site => 'thechangelog.com', :window => :hour)
      end
      
      should "return a page with a list of link search results for a query" do
        stub_get("/search.json?q=NYE&window=m", "search.json")
        results = Topsy.search("NYE", :window => :month)
        results.class.should == Topsy::Page
        results.total.should == 117731
        results.page.should == 1
        results.perpage.should == 10
        results.window.should == :month
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
    end
    
    


    should "return search counts for a term" do
      stub_get("/searchcount.json?q=Balloon%20Boy", "searchcount.json")
      counts = Topsy.search_count('Balloon Boy')
      counts.class.should == Topsy::SearchCounts
      counts.this_hour.should == 0
      counts.this_month.should == 3659
      counts.all_time.should == 42289
    end
    
    should "return a stats object for a url" do
      stub_get("/stats.json?url=http%3A%2F%2Fgithub.com%2Fpengwynn%2Flinkedin", "stats.json")
      stats = Topsy.stats("http://github.com/pengwynn/linkedin")
      stats.class.should == Topsy::Stats
      stats.topsy_trackback_url.should == "http://topsy.com/tb/github.com/pengwynn/linkedin"
      stats.contains.should == 0
      stats.all.should == 11
      stats.influential.should == 3
    end
    
    should "return a page with a list of tags associated with a url" do
      stub_get("/tags.json?url=http%3A%2F%2Fgemcutter.org", "tags.json")
      results = Topsy.tags("http://gemcutter.org")
      results.class.should == Topsy::Page
      results.total.should == 9
      results.list.first.class.should == Topsy::Tag
      assert results.list.map{|t| t.name}.include?("ruby")
      results.list.first.url.should == "http://topsy.com/s?q=itunesu"
      results.list.first.name.should == "itunesu"
    end
    
    should "return a page with a list of tweets (trackbacks) that mention the query URL" do
      stub_get("/trackbacks.json?url=http%3A%2F%2Forrka.com", "trackbacks.json")
      results = Topsy.trackbacks("http://orrka.com")
      results.class.should == Topsy::Page
      results.total.should == 3
      results.trackback_total.should == 3
      results.list.first.date.year.should == 2009
      results.list.first.permalink_url.should == "http://twitter.com/orrka/status/6435248067"
      results.list.first.date.should == Time.at(1260204073)
      results.list.first.content.should == "Just added some portfolio entries to http://orrka.com/"
      results.list.first['type'].should == "tweet"
      results.list.first.date_alpha.should == "25 days ago"
    end
    
    should "return a page with a list of trending terms" do
      stub_get("/trending.json", "trending.json")
      results = Topsy.trending
      results.class.should == Topsy::Page
      results.total.should == 1379
      results.list.first.class.should == Topsy::Trend
      assert results.list.map{|t| t.term}.flatten.include?("auld lang syne")
      results.list.first.url.should == "http://topsy.com/s?q=photoshop+photoshop"
      results.list.first.term.should == "photoshop photoshop"
    end
    
    should "return info about a url" do
      stub_get("/urlinfo.json?url=http%3A%2F%2Fwynnnetherland.com", 'urlinfo.json')
      results = Topsy.url_info('http://wynnnetherland.com')
      results.class.should == Topsy::UrlInfo
      results.trackback_total.should == 39379
      results.topsy_trackback_url.should == "http://topsy.com/tb/twitter.com/"
      results.oneforty.should == "trending topics -  -amp09 right up there past the president today! :) http://tiny.cc/3yNbv"
      results.url.should == "http://twitter.com/"
      results.title.should == "trending topics -  -amp09 right up there past the president today! :)"
      results.description.should == "Social networking"
      results.description_attribution.should == "From DMOZ"
    end
  end
  
end
