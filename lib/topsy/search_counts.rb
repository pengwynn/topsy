module Topsy
  class SearchCounts < Hashie::Dash
    property :h, :default => 0
    property :d, :default => 0
    property :w, :default => 0
    property :m, :default => 0
    property :a, :default => 0
    
    def last_hour
      h
    end
    
    def this_hour
      h
    end
    
    def today
      d
    end
    
    def last_week
      w
    end
    
    def this_week
      w
    end
    
    def last_month
      m
    end
    
    def this_month
      m
    end
    
    def all_time
      a
    end
    
    def overall
      a
    end
    
  end
end