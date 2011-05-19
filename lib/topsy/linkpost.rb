
module Topsy
  # This is the linkpost class for the topsy library. 
  # A Linkpost has the following attributes:
  #   "permalink_url" : "http://twitter.com/barackobama/status/3569838653",
  #   "target" : target instance
  #   "date" : "1251337427",
  #   "content" : "Highlights from the tribute to Sen. Kennedy's life and 
  #                accomplishments from last year's Democratic National Convention: http://bit.ly/TJcyr",
  #   "date_alpha" : "3 hours ago"
  # According to the official Topsy doc: http://code.google.com/p/otterapi/wiki/Resources?tm=6#/linkposts
  class Linkpost < Hashie::Dash
    property :permalink_url
    property :target
    property :date
    property :content
    property :date_alpha

    def to_s
      "Topsy Linkpost: #{permalink_url}, @#{content}"
    end
    
    def []=(property, value)
      case property
        when 'target' then
          if value
            self[:target] = Topsy::Target.new(value)  
          else
            self[:target] = value
          end
        else
          super(property.to_s, value)
      end
    end
  end
end
