module Topsy
	class TopsyError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

  class RateLimitExceeded < StandardError; end
  class Unauthorized      < StandardError; end
  class General           < TopsyError; end

  class Unavailable   < StandardError; end
  class InformTopsy < StandardError; end
  class NotFound      < StandardError; end
end