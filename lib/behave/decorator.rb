module Behave
  class Decorator
    autoload_modules :Configuration

    attr_accessor :name
    attr_accessor :configuration_class

    def initialize name
      @name = name
    end

    def internal_api name
    end

    def public_api name
    end

    def configuration_class
      @configuration_class || Behave::Decorator::Configuration
    end

    def decorate subject_class
      create_behavior_for(subject_class).apply!
    end

    def create_behavior_for subject_class
      Behave::Behavior.new name, subject_class, configuration_class
    end
  end
end

