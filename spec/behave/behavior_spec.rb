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

describe Behave::Behavior do
  before do
    Behave::Repository.empty!
  end

  describe '#new' do
    it 'should decorate a behavior' do
      behavior = Behave::Behavior.new :hello, User, MyBehavior::Configuration
      puts behavior.inspect
    end
  end

  describe '#create_behavior_for' do
    it 'should create a behavior for a subject' do
    end
  end
end

