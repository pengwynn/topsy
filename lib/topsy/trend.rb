# This is the trend class for the topsy library. 
# A Trend instance has the following attributes:
#            "url" : "http://topsy.com/s?q=dominick",
#            "term" : "dominick"
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/trending
#
module Topsy
  
  class Trend < Hashie::Mash
    
    def to_s
      "Topsy Trend: #{term}"
    end
    
  end
end
