module Behave
  class Behavior

    attr_accessor :name, :subject_class, :configuration

    # set classes to use for config, storage etc, also set general options
    # Example:
    #   Behave::Behavior.new :troles, subject_class, :config => Troles::Config, :message => 'hello'
    #
    # @param [Hash] class hash
    def intialize name, subject_class, configuration_class, options = {}
      @name = name
      @subject_class = subject_class
      @configuration_class = configuration_class
      conf_options.merge!(options)
    end

    # configures the behavior for the specific subject class
    def configure_with strategy = :default, options = {}, &block
      configuration = configuration_class.new subject_class, strategy, options

      configuration.load_adapter      
      subject_class.send :include, configuration.strategy_module

      configuration.define_hooks
      configuration.apply_strategy_options!
      
      yield config if block_given?
      config
    end

    def conf_options
      configuration.options
    end

    # set options
    def apply_options! options = {}
    end

    # @return [Behave::Config] instance of Behave::Config subclass specific for that behavior
    def config
      @config ||= config_class.new subject_class, options
    end

    # @return [Behave::Storage] instance of Behave::Storage subclass specific for that behavior
    def store
      @storage ||= storage_class
    end

    # For behavior :troles, defaults to Troles::Config    
    def config_class
      @config_class || "#{namespace}::Config".constantize
    end

    # For behavior :troles, defaults to Troles::Storage 
    def storage_class
      @storage_class || "#{namespace}::Storage".constantize
    end
    
    protected

    # if behavior is names trole, namespace becomes Troles
    def namespace
      name.to_s.camelize
    end
  end
end