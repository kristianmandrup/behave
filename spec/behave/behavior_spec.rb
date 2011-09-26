require 'behave/spec_helper'

# example Config class for behavior
module MyBehavior
  class Configuration < Behave::Decorator::Configuration
    def initialize subject_class, strategy, options = {}
      super
    end
  end
end

class User
end

module Hello
  class Configuration < Behave::Decorator::Configuration

    attr_writer :message

    def initialize subject_class, strategy, options = {}
      super
    end

    def hello
      @message || 'default message'
    end
  end

  class Config
    def apply_options! options={}
    end
  end
end

module MyBehavior
  module Api
    def hello
      "Hello you!"
    end
  end
end

# This is the implementation of the hello behavior
module Hello
  module Strategy
    module MyStrategy
      def self.included(base)
        # could also use contextualize here!!!
        base.send :include, MyBehavior::Api
      end
    end
  end
end

describe Behave::Behavior do
  let(:behavior) { Behave::Behavior.new :hello, User, MyBehavior::Configuration }

  before do
    Behave::Repository.empty!
  end

  describe '#new' do
    it 'should create a behavior' do
      behavior.name.should == :hello
      behavior.subject_class.should == User
      behavior.configuration_class.should == MyBehavior::Configuration
    end
  end

  describe '#configure!' do
    it 'should create a behavior for a subject' do
      behavior.configure! do |config|
      end
    end
  end

  describe '#configure_with' do
    it 'should create a behavior for a subject' do
      behavior.configure_with :my_strategy do |config|
      end
      behavior.configuration.strategy.should == :my_strategy
    end
  end

  describe '#apply!' do
    it 'should apply the behavior' do
      behavior.configure_with :my_strategy do |config|
      end

      behavior.apply!
      User.instance_methods.should include(:hello)
    end
  end
end

