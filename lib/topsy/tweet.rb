# This is the tweet class for the topsy library. 
# A Tweet instance has the following attributes:
#            "permalink_url" : "http://twitter.com/etagwerker/status/3565855201",
#            "date" : "1251324809",
#            "content" : "TOPSY - A search engine powered by tweets: http://topsy.com (this Search Engine can 
#                        be powerful for sifting through Twitter- love it)!",
#            "type" : "tweet",
#            "author" : author instance
#            "date_alpha" : "6 hours ago"
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/trackbacks
#
module Topsy
  
  class Tweet < Hashie::Dash
    property :permalink_url
    property :date
    property :content
    property :type
    property :author
    property :date_alpha
    property :target
    
    def to_s
      "Topsy Tweet: #{permalink_url}, #{content}"
    end

    def author=(value)
      if value
        self[:author] = Topsy::Author.new(value)  
      else
        self[:author] = value
      end
    end
    
    def target=(value)
      if value
        self[:target] = Topsy::Target.new(value)  
      else
        self[:target] = value
      end
    end
    
  end
end
