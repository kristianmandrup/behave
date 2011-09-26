module Behave
  # The #behaviors collection of the subject class is populated by instances of Behave::Behavior. 
  # Each such behavior has a relationship to a Behave::Decorator instance with the same name, registered in the repository (registered_behaviors hash).
  # A Behave::Decorator instance has a Behave::Decorator::Configuration object that knows how to configure the behavior 
  # for a Class (i.e in a given context).

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

