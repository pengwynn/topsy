# This is the page class for the topsy library. 
# A Page has the following attributes:
#      "page" : 1,
#      "total" : "1139",
#      "perpage" : 15,
#      "list" : Array of Author instances
#      "window" : Optional symbol
#      "topsy_trackback_url" : String, optional 
#      "trackback_total": 165, optional
#
# According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/authorsearch
#
module Topsy
  
  class Page < Hashie::Dash
    property :total
    property :trackback_total
    property :list
    property :page
    property :perpage
    property :window
    property :topsy_trackback_url
    property :last_offset
    property :offset
    property :hidden
    
    @@windows = {'a' => :all, 'auto' => :auto, 'w' => :week, 'd' => :day, 'm' => :month, 'h' => :hour}
    
    def to_s
      "Topsy Page: #{page} of #{total}, #{list.size} authors"
    end

    def initialize(content, klass)
      @klass = klass
      super(content)
    end
    
    def []=(property, value)
      case property
        when 'list' then
          result = []
          if value
            value.each{ |x| result << @klass.new(x) }
            self[:list] = result  
          else
            self[:list] = value
          end
        when 'window' then
          if value
            self[:window] = @@windows[value]  
          end
        else
          super(property.to_s, value)
      end
    end
  end
 
end
