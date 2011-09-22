module Behave
  class Decorator
    class Configuration

      attr_accessor :strategy
      attr_reader :name, :orm, :auto_load, :options, :subject_class
      attr_writer :config_class, :storage_class

      def initialize name, subject_class, options = {}
        @name = name
        @subject_class = subject_class
        @strategy = options[:strategy]
        @orm = options[:orm] || Behave::Config.default_orm
        @auto_load = options[:auto_load]

        options[:strategy] = strategy

        classes = options.select{|k, v| k.to_s =~ /_class$/} # extract keys ending with _class
        options.delete_if {|k,v| classes.include? k} # remaining keys are normal options

        # set config_class etc. using hash (optional config option in case you want to override defaults)
        classes.each_pair do |name, clazz|
          meth = "#{name}_class="
          send(meth, clazz) if self.respond_to?(meth) && clazz.is_a(Class)
        end

        @options = options
      end

      # this is used to load a specific ORM adapter, such as for Active Record or Mongoid etc. 
      def load_adapter
        return false if !auto_load?

        path = "#{namespace}/adapters/#{orm.to_s.underscore}"
        begin
          require path
        rescue
          raise "Adapter for :#{orm} could not be found at: #{path}"
        end
      end

      # see(#load_adapter)
      def namespace
        name
      end

      # whether to auto load an ORM adapter
      # see(#load_adapter)
      def auto_load?
        (auto_load && orm) || false
      end

      # used to turn storage on/off ?
      # some behaviors have no storage need
      def storage?
        options[:storage]
      end

      # used to turn config on/off ?
      # some behaviors have no config, and imply need to apply an API via the strategy module!
      def config?
        options[:config]
      end

      # use loaders to try to find classses using naming conventions
      def storage_class
        @storage_class || storage_loader.storage_class
      end

      def config_class
        @config_class || config_loader.config_class
      end

      def strategy_module
        strategy_loader.strategy_module
      end

      protected

      [:storage, :config, :strategy].each do |type|
        class_eval %{
          def #{type}_loader
            @#{type}_loader ||= Behave::Loaders::#{type.to_s.camelize}Loader.new name, strategy, orm
          end
        }
      end
    end
  end
end
