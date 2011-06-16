require 'behave/spec_helper'

# example Config class for behavior
module MyBehavior
  class Configuration < Behave::Decorator::Configuration
    def initialize subject_class, strategy, options = {}
      super
    end
  end
end

describe Behave::Decorator do
  before do
    Behave::Repository.empty!
  end
  
  describe '#add_behavior' do
    it 'should add a behavior with config class' do
      Behave::Repository.add_behavior(:hello) do |behavior|
        behavior.configuration_class = MyBehavior::Configuration
      end
      
      Behave::Repository.behaviors[:hello].configuration_class.should == MyBehavior::Configuration 
    end
  end
end
