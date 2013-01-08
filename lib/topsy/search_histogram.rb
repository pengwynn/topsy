# This is the search_histogram class for the topsy library. 
# A SearchHistogram has the following attributes:
# 	"histogram":[21024,10386,7270,12722,15993,17522,10517,8899,10363,11491,11729,16262,12940,8800,7589,8275,8692,14924,25927,30728,24562,22369,19203,33483,15497,11527,11814,11893,13998,7268],
# 	"period":30,
# 	"count_method":"citation",
# 	"slice":86400
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources#/searchhistogram
#
module Topsy
  
  class SearchHistogram < Hashie::Mash
    
    def to_s
      "Topsy SearchHistogram: #{histogram}, Period: #{period}, Count Method: #{count_method} , Slice: #{slice}"
    end
    
  end
end
