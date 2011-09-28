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

  let(:decorator) { Behave::Decorator.new :my_dec }



  describe '#decorate' do
    let(:subj_class) { MyBehavior }

    it 'should decorate a behavior' do
      res = decorator.decorate(subj_class)
      puts res.inspect
    end
  end

  describe '#create_behavior_for' do
    it 'should create a behavior for a subject' do
      # puts decorator.send :create_behavior_for, subj_class
    end
  end
end
