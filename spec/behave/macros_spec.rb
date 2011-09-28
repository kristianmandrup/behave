require 'behave/spec_helper'
require 'fixtures/models'

describe Behave::Macros do
  before(:all) do
    Behave::Repository.empty! # need to do this, because of running the whole spec suite
  end

  context 'User instance' do
    describe '#behave!' do
      let(:user) { User.new }
      it 'should add behaviors hash' do
        user.behave!
        user.behaviors.should be_kind_of(Hash)
      end
    end
  end
end

describe Behave::Macros do
  before(:all) do
    Behave::Repository.empty! # need to do this, because of running the whole spec suite
  end

  context 'User class' do
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
        User.behavior(:hello) do |behavior|
          behavior.configuration.message = 'hello'
        end.apply!

        User.new.hello.should == 'hello'
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
        User.behave!
        User.behavior(:hello).apply!
        User.has_behavior?(:hello).should be_true
      end
    end
  end
end

