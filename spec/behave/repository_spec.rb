# This is to test how you can add behaviors to the set of global behaviors!describe Behave::Macros do
# The Behave module acts as a repository for registering behaviors that can then be added to individual classes

require 'behave/spec_helper'

describe Behave::Repository do
  describe '#add_behavior' do
    after(:each) do
      Behave::Repository.empty!
    end

    it 'should add a named behavior' do
      Behave::Repository.add_behavior(:hello).should be_a(Behave::Decorator)
    end

    it 'should add a behavior with config class' do
      Behave::Repository.add_behavior(:hey) do |behavior|
        behavior.should be_a(Behave::Decorator)
      end.should be_a(Behave::Decorator)
    end
  end

  describe '#register_behavior' do
    it 'should add a named behavior' do
      Behave::Repository.register_behavior(:hi).should be_a(Behave::Decorator)
    end
  end

  describe '#has_behavior?' do
    it 'should add a named behavior' do
      Behave::Repository.has_behavior?(:hi).should be_true
    end
  end

  describe '#remove_behavior' do
    it 'should remove a named behavior' do
      Behave::Repository.remove_behavior(:hi)
      Behave::Repository.has_behavior?(:hi).should be_false
    end    
  end

  describe '#empty!' do
    it 'should remove all behaviors' do
      Behave::Repository.empty!
      Behave::Repository.registered_behaviors.should be_empty
    end    
  end
  
  describe '#registered_behaviors' do 
    before(:all) do
      Behave::Repository.add_behavior(:hello) do |behavior|
        behavior.should be_a(Behave::Decorator)
      end
    end

    it 'should contain globally registered behaviors' do
      Behave::Repository.registered_behaviors.should_not be_empty
    end
 end

  describe 'behavior' do
    it 'should have hello' do
      Behave::Repository.behavior(:hello).should be_a(Behave::Decorator)
    end
  end
end
