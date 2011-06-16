module Behave
  class Decorator
    autoload :Configuration, 'behave/decorator/configuration'
    
    attr_accessor :name, :configuration_class

    def initialize name
      @name = name
    end
    
    def internal_api name
    end

    def public_api name
    end

    def configuration_class
      @configuration_class || Configuration
    end

    def create_behavior_for subject_class
      Behave::Behavior.new name, subject_class, configuration_class
    end        
  end
end

