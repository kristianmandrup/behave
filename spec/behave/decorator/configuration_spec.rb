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

# This is the implementation of the hello behavior
module MyBehavior
  module Api
    def hello
      puts "Hello you!"
    end
  end

  module Strategy
    module MyStrategy
      def self.included(base)
        puts "Strategy MyStrategy for #{base}"
        base.send :include, MyBehavior::Api
      end
    end
  end
end

describe Behave::Decorator::Configuration do
  context 'default' do
    describe '#new' do
      let(:configuration) do
        Behave::Decorator::Configuration.new :hello, User, {:strategy => :my_strategy }
      end

      it 'should create a decorator configuration' do
        configuration.name.should == :hello
        configuration.subject_class.should == User
        configuration.strategy.should == :my_strategy
        configuration.orm.should == Behave::Config.default_orm
      end
    end
  end

  context 'set orm mongoid' do
    describe '#new' do
      let(:configuration) do
        Behave::Decorator::Configuration.new :hello, User, {:strategy => :my_strategy, :orm => :mongoid }
      end

      it 'should have mongoid orm' do
       configuration.orm.should == :mongoid
      end
    end
  end

  describe '#load_adapter' do
    it 'should load an adapter if such exists using naming convention' do
      configuration.load_adapter
    end
  end
end
