# This is the url_info class for the topsy library. 
# An UrlInfo has the following attributes:
#      "topsy_trackback_url" : "http://topsy.com/tb/twitter.com/",
#      "oneforty" : "Twitter: What are you doing? http://twurl.nl/pd8k44",
#      "url" : "http://etagwerker.com/",
#      "title" : "Tech Notes From The Trenches",
#      "trackback_total" : "24152",
#      "description" : "Social networking and microblogging service utilising instant messaging, SMS or a web interface.",
#      "description_attribution" : "From DMOZ"
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/urlinfo
#
module Topsy
  
  class UrlInfo < Hashie::Mash
    
    def to_s
      "Topsy UrlInfo: #{url}, @#{topsy_trackback_url}, #{trackback_total} total"
    end
    
  end
end
