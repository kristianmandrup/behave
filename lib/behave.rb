require 'behave/macros'

module Behave
  autoload :Config,       'behave/config'
  autoload :Decorator,    'behave/decorator'
  autoload :Repository,   'behave/repository'

  autoload :BaseLoader,     'behave/loaders/base_loader'
  autoload :ConfigLoader,   'behave/loaders/config_loader'
  autoload :StrategyLoader, 'behave/loaders/strategy_loader'
  autoload :StorageLoader,  'behave/loaders/storage_loader'
end
