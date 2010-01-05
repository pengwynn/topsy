# This is the linkpost_count class for the topsy library. 
# A LinkpostCount has the following attributes:
#        "contains" : 0,
#        "all" : 46
# 
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/linkpostcount
#
module Topsy
  
  class LinkpostCount < Hashie::Mash
    def to_s
      "Topsy LinkpostCount: #{all}"
    end
  end
end
