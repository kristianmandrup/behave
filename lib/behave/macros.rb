# 
# @author Kristian Mandrup
#
# Macros that can be used directly on the role subject class 
# These methods are added to the ruby core 'Module' module
#
# Usage:
#   class User
#     troles_strategy :bit_many
#

module Behave
  module Macros
    # Adds a behaviors collection to the subject class or module
    # This collection should initially be empty
    # It can be populated by Behave::Behavior instances that are configured according to the Behave::Decorators in the repository
    # for the given behavior
    def behave!
      self.singleton_class.class_eval %{
        def behaviors
          @behaviors ||= {}
        end
      }
    end

    # returns the given named behavior from the subject's list of behaviors
    # @return [Behave::Behavior] the named behavior
    def behavior name, &block
      behave! unless respond_to? :behaviors
      return behaviors[name.to_sym] if has_behavior? name

      decorator = Behave::Repository.behavior name
      puts "Decorator:" << decorator.inspect
      puts "BHH" << decorator.create_behavior_for(self).inspect

      behaviors[name.to_sym] = decorator.create_behavior_for(self)
      result = behaviors[name.to_sym]
      puts "Res:" << result.inspect

      yield result if block
      result
    end

    # @return [true, false] true if the given behavior is already in the subject's list of behaviors
    def has_behavior? name
      return false unless respond_to? :behaviors
      behaviors.keys.include? name.to_sym
    end
  end
end

Module.send :include, Behave::Macros
