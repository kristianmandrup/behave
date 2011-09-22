require 'behave/spec_helper'

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

module Hello
  module Api
    def hello
      behavior(:hello).configuration.message
    end
  end

  module Strategy
    module Default
      def self.included(base)
        base.send :include, Hello::Api
      end
    end
  end
end

describe Behave::Macros do
  before(:all) do
    Behave::Repository.empty! # need to do this, because of running the whole spec suite
  end

  describe '#behave!' do
    it 'should add behaviors hash' do
      User.behave!
      User.behaviors.should be_kind_of(Hash)
    end
  end

  describe '#behavior' do
    before(:all) do
      Behave::Repository.add_behavior(:hello) do |behavior|
        behavior.configuration_class = Hello::Configuration
      end
    end

    it 'should add behavior' do
      User.behavior(:hello).should_not be_nil
    end

    it 'should configure User with hello method that returns message' do
      behavior = User.behavior(:hello) do |c|
        c.message = 'hello'
      end
      behavior.configure!

      # User.hello.should == 'hello'
    end
  end

  describe '#has_behavior?' do
    before(:all) do
      Behave::Repository.empty!
      Behave::Repository.add_behavior(:hello) do |behavior|
        behavior.configuration_class = Hello::Configuration
      end
    end

    it 'should have behavior' do
      # User.behave!
      # User.behavior(:hello).configure!
      # User.has_behavior?(:hello).should be_true
    end
  end
end

