class User
end


module Hello
  class Configuration < Behave::Decorator::Configuration

    attr_writer :message

    def initialize subject_class, strategy, options = {}
      super
    end

    def message
      @message || 'default message'
    end
  end

  class Config
    def apply_options! options={}
    end
  end
end

# This is the implementation of the hello behavior
module Hello
  module Api
    def hello
      # use the hello behavior configuration
      self.class.behavior(:hello).configuration.message
    end
  end

  module Strategy
    module Default
      def self.included(base)
        puts "Strategy Default for #{base}"
        base.send :include, Hello::Api
      end
    end

    module MyStrategy
      def self.included(base)
        puts "Strategy MyStrategy for #{base}"
        base.send :include, Hello::Api
      end
    end
  end
end

