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

  describe '#decorate' do
    it 'should decorate a behavior' do
      pending
    end
  end

  describe '#create_behavior_for' do
    it 'should create a behavior for a subject' do
      pending
    end
  end
end
