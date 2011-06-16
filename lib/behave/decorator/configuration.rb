module Behave  
  class Decorator    
    class Configuration
            
      attr_reader :strategy, :orm, :auto_load, :options, :subject_class 
      attr_writer :config_class, :storage_class
      
      def initialize subject_class, strategy, options = {}
        @subject_class = subject_class
        @strategy = strategy
        @orm = options[:orm] || Behave::Config.default_orm
        @auto_load = options[:auto_load]

        options[:strategy] = strategy
        
        classes = options.select{|k, v| k.to_s =~ /_class$/} # extract keys ending with _class
        options.delete_if {|k,v| classes.include? k} # remaining keys are normal options

        # set config_class etc. using hash
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

      def namespace
        behavior.name
      end

      # storage

      # used to turn storage on/off ?
      def storage?
        options[:storage]
      end

      def storage_class
        @storage_class || storage_loader.storage_class
      end

      def storage_loader
        @storage_loader ||= StorageLoader.new strategy, orm
      end

      # config

      # used to turn config on/off ?
      def config?
        options[:config]
      end

      def config_class
        @config_class || config_loader.config_class
      end

      def config_loader
        @config_loader ||= ConfigLoader.new strategy, orm
      end

      # strategy

      def strategy_module
        strategy_loader.strategy_module
      end

      def strategy_loader
        @strategy_loader ||= StrategyLoader.new strategy, orm
      end

      def auto_load?
        (auto_load && orm) || false
      end  
    end
  end
end