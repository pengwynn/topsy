module Topsy
  class Client
    include HTTParty
    format :json
    base_uri "http://otter.topsy.com"
    @@windows = {:all => 'a', :auto => 'auto', :week => 'w', :day => 'd', :month => 'm', :hour => 'h'}
    
    # Returns info about API rate limiting
    #
    # @return [Topsy::RateLimitInfo]
    def credit
      handle_response(self.class.get("/credit.json"))
    end
    
    # Returns Profile information for an author (a twitter profile indexed by Topsy). The response contains the name, description (biography) and the influence level of the author
    #
    # @param [String] url URL string for the author.
    # @return [Topsy::Author]
    def author_info(url)
      authorinfo = handle_response(self.class.get("/authorinfo.json", :query => {:url => url}))
      Topsy::Author.new(authorinfo)
    end

    # Returns list of authors that talk about the query. The list is sorted by frequency of posts and the influence of authors.
    #
    # @param [String] q the search query string
    # @param [Hash] options method options
    # @option options [Symbol] :window Time window for results. (default: :auto) Options: :auto - automatically pick the most recent and relevant window. :hour last hour, :day last day, :week last week, :month last month, :all all time
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Hashie::Mash]
    def author_search(q, options={})
      options[:window] = @@windows[options[:window]] if options[:window]
      handle_response(self.class.get("/authorsearch.json", :query => {:q => q}.merge(options)))
    end
    
    # Returns list of URLs posted by an author
    #
    # @param [String] url URL string for the author.
    # @param [Hash] options method options
    # @option options [String] :contains Query string to filter results
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def link_posts(url, options={})
      linkposts = handle_response(self.class.get("/linkposts.json", :query => {:url => url}.merge(options)))
      Topsy::Page.new(linkposts,Topsy::Linkpost)
    end
    
    # Returns count of links posted by an author. This is the efficient, count-only version of /linkposts
    #
    # @param [String] url URL string for the author.
    # @param [Hash] options method options
    # @option options [String] :contains Query string to filter results
    # @return [Topsy::LinkpostCount]
    def link_post_count(url, options={})
      count = handle_response(self.class.get("/linkpostcount.json", :query => {:url => url}.merge(options)))
      Topsy::LinkpostCount.new(count)
    end
    
    # Returns list list of author profiles that match the query. The query is matched against the nick, name and biography information and the results are sorted by closeness of match and the influence of authors.
    #
    # @param [String] q the search query string
    # @param [Hash] options method options
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def profile_search(q, options={})
      results = handle_response(self.class.get("/profilesearch.json", :query => {:q => q}.merge(options)))
      Topsy::Page.new(results,Topsy::Author)
    end
    
    # Returns list of URLs related to a given URL
    #
    # @param [String] url URL string for the author.
    # @param [Hash] options method options
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def related(url, options={})
      response = handle_response(self.class.get("/related.json", :query => {:url => url}.merge(options)))
      Topsy::Page.new(response,Topsy::LinkSearchResult)
    end
    
    # Returns list of results for a query.
    #
    # @param [String] q the search query string
    # @param [Hash] options method options
    # @option options [Symbol] :window Time window for results. (default: :auto) Options: :auto - automatically pick the most recent and relevant window. :hour last hour, :day last day, :week last week, :month last month, :all all time
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def search(q, options={})
      options[:window] = @@windows[options[:window]] if options[:window]
      results = handle_response(self.class.get("/search.json", :query => {:q => q}.merge(options)))
      Topsy::Page.new(results,Topsy::LinkSearchResult)
    end

    # Returns count of results for a search query.
    #
    # @param [String] q the search query string
    # @return [Topsy::SearchCounts]
    def search_count(q)
      counts = handle_response(self.class.get("/searchcount.json", :query => {:q => q}))
      Topsy::SearchCounts.new(counts)
    end
    
    # Returns counts of tweets for a URL
    #
    # @param [String] url the url to look up
    # @param [Hash] options method options
    # @option options [String] :contains Query string to filter results
    # @return [Topsy::Stats]
    def stats(url, options={})
      query = {:url => url}
      query.merge!(options)
      response = handle_response(self.class.get("/stats.json", :query => query))
      Topsy::Stats.new(response)
    end
    
    # Returns list of tags for a URL.
    #
    # @param [String] url the search query string
    # @param [Hash] options method options
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def tags(url, options={})
      response = handle_response(self.class.get("/tags.json", :query => {:url => url}.merge(options)))
      Topsy::Page.new(response,Topsy::Tag)
    end
    
    # Returns list of tweets (trackbacks) that mention the query URL, most recent first.
    #
    # @param [String] url URL string for the author.
    # @param [Hash] options method options
    # @option options [String] :contains Query string to filter results
    # @option options [Boolean] :infonly filters trackbacks to influential only (default 0)
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def trackbacks(url, options={})
      results = handle_response(self.class.get("/trackbacks.json", :query => {:url => url}.merge(options)))
      results.list.each do |trackback|
        trackback.date = Time.at(trackback.date)
      end
      Topsy::Page.new(results,Topsy::Tweet)
    end
    
    # Returns list of trending terms
    #
    # @param [Hash] options method options
    # @option options [Integer] :page page number of the result set. (default: 1, max: 10)
    # @option options [Integer] :perpage limit number of results per page. (default: 10, max: 50)
    # @return [Topsy::Page]
    def trending(options={})
      response = handle_response(self.class.get("/trending.json", :query => options))
      Topsy::Page.new(response,Topsy::Trend)
    end
    
    # Returns info about a URL
    #
    # @param [String] url the url to look up
    # @return [Topsy::UrlInfo]
    def url_info(url)
      response = handle_response(self.class.get("/urlinfo.json", :query => {:url => url}))
      Topsy::UrlInfo.new(response)
    end

    private

      def handle_response(response)
        raise_errors(response)
        get_rate_limit_status(response)
        mashup(response)
      end

      def raise_errors(response)
        code = response.code.to_i
        case code
        when 400
          raise Topsy::General.new("Parameter check failed. This error indicates that a required parameter is missing or a parameter has a value that is out of bounds.")
        when 403
          raise Topsy::Unauthorized.new
        when 404
          raise Topsy::NotFound.new
        when 500
          raise Topsy::InformTopsy.new
        when 503
          raise Topsy::Unavailable.new
        end
      end

      def mashup(response)
        Hashie::Mash.new(response).response
      end
      
      def get_rate_limit_status(response)
        headers = {
          'limit' => response.headers['x-ratelimit-limit'].first.to_i,
          'remaining' => response.headers['x-ratelimit-remaining'].first.to_i,
          'reset' => response.headers['x-ratelimit-reset'].first.to_i
        }
        Topsy.rate_limit = Topsy::RateLimitInfo.new(headers)
      end

  end
end