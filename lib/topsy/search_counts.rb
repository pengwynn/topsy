module Topsy
  class SearchCounts < Hashie::Dash
    property :h, :default => 0
    property :d, :default => 0
    property :w, :default => 0
    property :m, :default => 0
    property :a, :default => 0
    
    alias :hour :h
    alias :this_hour :h
    
    alias :today :d
    
    alias :week :w
    alias :this_week :w
    
    alias :month :m
    alias :this_month :m
    
    alias :overall :a
    alias :all_time :a
    
    
  end
end