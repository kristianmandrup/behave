class User
end

module Troles
  class Configuration < Behave::Decorator::Configuration

    attr_writer :valid_roles

    def initialize subject_class, strategy, options = {}
      super
    end

    def valid_roles
      @valid_roles || [:guest, :admin]
    end
  end

  class Config
    attr_accessor :valid_roles

    def apply_options! options={}
    end
  end
end

# This is the implementation of the hello behavior
module Troles
  module Api
    def valid_roles
      # use the hello behavior configuration
      self.class.behavior(:troles).configuration.valid_roles
    end
  end

  module Strategy
    module Default
      def self.included(base)
      	puts "add Strategy Default api to #{base}"
        base.send :include, Troles::Api
      end
    end
  end
end