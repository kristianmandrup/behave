# This will acts as a Repository (singleton) for registering behaviors that then be added to modules/classes of choice using the behavior(name) macro.

module Behave
  module Repository  
    module ClassMethods
      attr_accessor :behaviors

      # Add a new behavior to the global set of available behaviors!
      # The behaviors contained here can later be added to subject classes
      def add_behavior name, &block
        raise ArgumentError, "Behavior '#{name}' already available" if has_behavior?(name)
        new_behavior = create_behavior name
        behaviors[name] = new_behavior
        yield new_behavior if block
        new_behavior
      end 

      def remove_behavior name
         behaviors.delete name.to_sym
      end

      def empty!
        behaviors.clear
      end

      def behaviors
        @behaviors ||= {}
      end

      def has_behavior? name
        behaviors.include? name.to_sym
      end

      private
  
      def create_behavior name
        Behave::Decorator.new name
      end
    end

    extend ClassMethods
  end
end
