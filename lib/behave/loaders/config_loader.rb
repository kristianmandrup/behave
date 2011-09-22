module Behave
  module Loaders
    class ConfigLoader < BaseLoader
      def initialize name, strategy, orm
        super
      end

      def config_class
        @config_class ||= find_first_class("#{orm_namespace}::Config", "#{namespace}::Config")
      end
    end
  end
end

