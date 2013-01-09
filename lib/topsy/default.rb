module Topsy
  module Default
    class << self
      # @return [Hash]
      def options
        Hash[Topsy::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def api_key
        ""
      end
    end
  end
end