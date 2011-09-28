require 'sweetloader'
require 'contextualize'
require 'sugar-high/kind_of'
require 'behave/macros'

module Behave
  autoload_modules :Config, :Decorator, :Behavior, :Repository, :Loaders
end
