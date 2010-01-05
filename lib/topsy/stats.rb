# This is the stats class for the topsy library. 
# A Stats instance has the following attributes:
#      "topsy_trackback_url" : "http://topsy.com/tb/etagwerker.com/",
#      "contains" : "1931",
#      "influential" : "874",
#      "all" : "1931"
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/stats
#
module Topsy
  
  class Stats < Hashie::Mash
    
    def to_s
      "Topsy Stats: #{topsy_trackback_url}"
    end
    
  end
end
