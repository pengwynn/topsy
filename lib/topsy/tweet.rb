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
  
  class Tweet < Hashie::Mash
    
    def to_s
      "Topsy Tweet: #{permalink_url}, #{content}"
    end

    def []=(property, value)
      case property
        when 'author' then
          if value
            self[:author] = Topsy::Author.new(value)  
          else
            self[:author] = value
          end
        when 'target' then
          if value
            self[:target] = Topsy::Target.new(value)  
          else
            self[:target] = value
          end
        else
          super(property.to_s, value)
      end
    end
  end
end
