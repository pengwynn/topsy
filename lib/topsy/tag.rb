# This is the tag class for the topsy library. 
# A Tag instance has the following attributes:
#            "url" : "http://topsy.com/s?q=current",
#            "name" : "current"
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/tags
#
module Topsy
  
  class Tag < Hashie::Mash
    
    def to_s
      "Topsy Tag: #{name}"
    end
    
  end
end
