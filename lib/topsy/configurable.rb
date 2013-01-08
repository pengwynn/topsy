require 'topsy/default'
module Topsy
  module Configurable
    attr_writer :api_key
    attr_accessor :endpoint, :connection_options, :middleware, :access_token_key

    class << self

      def keys
        @keys ||= [
          :api_key
        ]
      end

    end
    
    # Convenience method to allow configuration options to be set in a block
    def configure
      yield self
      self
    end

    # @return [Fixnum]
    def cache_key
      options.hash
    end

    def reset!
      Topsy::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Topsy::Default.options[key])
      end
      self
    end
    alias setup reset!

  private

    # @return [Hash]
    def options
      Hash[Topsy::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end

  end
end
