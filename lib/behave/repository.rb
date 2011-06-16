# This will acts as a Repository (singleton) for registering behaviors that then be added to modules/classes of choice using the behavior(name) macro.

module Behave
  module Repository  
    module ClassMethods
      attr_accessor :behaviors

      # Add a new behavior to the global set of registered behaviors!
      # The behaviors contained here can later be added to subject classes
      # 
      # @param [String, Symbol] the name of the behavior to add
      # @param [block] yields the behavior so that it can be configure
      #
      def register_behavior name, &block
        raise ArgumentError, "Behavior '#{name}' already available" if has_behavior?(name)
        new_behavior = create_behavior name
        registered_behaviors[name] = new_behavior
        yield new_behavior if block
        new_behavior
      end 

      # removes the named behavior from the registered behaviors repo
      def remove_behavior name
         behaviors.delete name.to_sym
      end

      # clear all registered behaviors!
      def empty!
        registered_behaviors.clear
      end

      # initially behaviors in repo should be empty
      # each behavior can be looked up by name, and references a behavior
      # so a natural fir is to store them in a Hash, where the name is the lookup key
      # the behaviors stored should each be an instance of Behave::Decorator
      def registered_behaviors
        @registered_behaviors ||= {}
      end

      def behavior name
        raise ArgumentError, "Behavior '#{name}' already available" if has_behavior?(name)
        return registered_behaviors[name.to_sym] if has_behavior? name        
      end

      # checks whether the behaviors hash contains a key for the named behavior
      def has_behavior? name
        registered_behaviors.include? name.to_sym
      end

      private

      # creates a new Behavior Decorator
      def create_behavior name
        Behave::Decorator.new name
      end
    end

    extend ClassMethods
  end
end
