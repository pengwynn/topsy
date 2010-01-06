# This is the author class for the topsy library. 
# An Author has the following attributes:
#      "name" : "Barack Obama"
#      "url" : "http://twitter.com/barackobama",
#      "topsy_type" : "twitter",
#      "nick" : "barackobama",
#      "description" : "44th President of the United States",
#      "topsy_author_url" : "http://topsy.com/twitter/barackobama",
#      "influence_level" : "5" 
# 
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/authorinfo
module Topsy
  
  class Author < Hashie::Mash
    def to_s
      "Topsy Author: #{name}, @#{nick}, #{topsy_author_url}"
    end
    
    def type
      self[:type]
    end
  end
end
