require 'behave/spec_helper'
require 'fixtures/troles_behavior'

describe Behave::Behavior do  
  before do
    # Behave::Repository.empty!
  end

  describe 'add global troles behavior' do
  	it 'should register the behavior' do
      Behave::Repository.add_behavior(:troles) do |behavior|
      	behavior.configuration_class = Troles::Configuration
      end.should be_a(Behave::Decorator)
      Behave::Repository.registered_behaviors.should_not be_empty
  	end

  	it 'should configure the troles behavior for the User class' do
  	  User.behave!
	  Behave::Repository.registered_behaviors.should_not be_empty

 	  User.behavior(:troles).configure_with :default do |c|
  		c.valid_roles = [:user, :admin]
	  end
	  User.behavior(:troles).apply!
	  User.new.valid_roles.should_not be_empty
	end
  end
end
