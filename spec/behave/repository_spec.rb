# This is to test how you can add behaviors to the set of global behaviors!describe Behave::Macros do
# The Behave module acts as a repository for registering behaviors that can then be added to individual classes

require 'behave/spec_helper'

describe Behave::Repository do
  describe '#add_behavior' do
    it 'should add a named behavior' do
      Behave::Repository.add_behavior(:hello).should be_a(Behave::Decorator)
    end

    it 'should add a behavior with config class' do
      Behave::Repository.add_behavior(:hello) do |behavior|
        behavior.should be_a(Behave::Decorator)
      end
    end
  end

  describe '#behaviors' do  
    it 'should contain global behaviors' do
      Behave::Repository.behaviors.should_not be_empty
    end
    
    it 'should have hello' do
      Behave::Repository.behaviors[:hello].should be_a(Behave::Decorator)
    end
  end

  describe 'behavior' do  
    it 'should have behavior' do
      Behave::Repository.behaviors[:hello].config.should be_a(Behave::Config)
    end
  end  
end

