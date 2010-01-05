# This is the target class for the topsy library. 
# A Target has the following attributes:
#      "topsy_trackback_url" : "http://topsy.com/tb/my.barackobama.com/page/community/post/obamaforamerica/gGMPVm",
#      "url" : "http://my.barackobama.com/page/community/post/obamaforamerica/gGMPVm",
#      "trackback_total" : "43"
# 
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/linkposts
#
module Topsy
  
  class Target < Hashie::Mash

    def to_s
      "Topsy Target: #{url}"
    end
    
  end
end
