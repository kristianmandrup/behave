require 'sugar-high/class_ext'
module Behave
  class BaseLoader
    attr_reader :name, :strategy, :orm

    include ClassExt

    def initialize name, strategy, orm
      @name = name
      @strategy = strategy
      @orm = orm || Behave::Config.default_orm
    end

    def singularity
      (strategy =~ /_many$/) ? :many : :one
    end

    def strategy_class
      strategy.to_s.camelize
    end

    def base_class
      "Base#{singularity.to_s.camelize}"
    end

    def namespace
      name.to_s.camelize
    end

    def orm_namespace
      ns = namespace
      ns << "::#{orm.to_s.camelize}" if orm
      ns
    end
  end

end
