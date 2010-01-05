# This is the page class for the topsy library. 
# A Page has the following attributes:
#      "page" : 1,
#      "total" : "1139",
#      "perpage" : 15,
#      "list" : Array of Author instances 
#
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/authorsearch
#
module Topsy
  
  class Page < Hashie::Dash
    property :total
    property :list
    property :page
    property :perpage
    property :window
    
    def to_s
      "Topsy Page: #{page} of #{total}, #{list.size} authors"
    end

    def initialize(content, klass)
      @klass = klass
      super(content)
    end
    
    def list=(value)
      result = []
      if value
        value.each{ |x| result << @klass.new(x) }
        self[:list] = result  
      else
        self[:list] = value
      end
    end
  end
 
end
