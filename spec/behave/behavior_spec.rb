require 'behave/spec_helper'
require 'fixtures/models'

describe Behave::Behavior do
  let(:behavior) { Behave::Behavior.new :hello, User, Hello::Configuration }

  before do
    Behave::Repository.empty!
  end

  describe '#new' do
    it 'should create a behavior' do
      behavior.name.should == :hello
      behavior.subject_class.should == User
      behavior.configuration_class.should == Hello::Configuration
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

