module Topsy
  
  class RateLimitInfo < Hashie::Dash
    
    property :reset
    property :limit
    property :remaining
    
    def refresh_in_seconds
      Time.at(reset) - Time.now
    end
    
    def reset
      Time.at(self[:reset]) unless self[:reset].respond_to?(:year)
    end
  end
  
end