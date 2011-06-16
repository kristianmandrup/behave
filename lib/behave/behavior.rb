module Behave
  class Behavior
    attr_accessor :name, :subject_class, :configuration

    # set classes to use for config, storage etc, also set general options
    # Example:
    #   Behave::Behavior.new :troles, subject_class, configuration_class, :message => 'hello'
    #
    # @param [Hash] class hash
    def intialize name, subject_class, configuration_class, options = {}
      @name = name
      @subject_class = subject_class
      @configuration_class = configuration_class
      conf_options.merge!(options)
    end

    # configures the behavior for the specific subject class
    # what should really happen here?
    # what is the minimal list of things to do for any behavior, and what are the nice "add-ons" 
    # and how can we make a flexible hook-system for these?    
    def configure_with strategy = :default, options = {}, &block
      # create instance of configuration class from repo
      configuration = configuration_class.new subject_class, strategy, options

      # use configuration to load adapter!
      configuration.load_adapter      

      # apply options to config
      config.apply_options! options
            
      yield config if block_given?
      config
    end

    # apply the behavior to the subject
    def apply!
      # include the strategy module of the configuration directly on the subject, thus applying the API etc
      subject_class.send :include, configuration.strategy_module      
    end

    # configuration options
    def conf_options
      configuration.options
    end

    # @return [Behave::Config] instance of Behave::Config subclass specific for that behavior
    def config
      @config ||= config_class.new subject_class, options
    end

    # @return [Behave::Storage] instance of Behave::Storage subclass specific for that behavior
    def store
      @storage ||= storage_class
    end
    
    protected

    # For behavior :troles, defaults to Troles::Config    
    def config_class
      @config_class ||= configuration.config_class  || "#{namespace}::Config".constantize
    end

    # For behavior :troles, defaults to Troles::Storage 
    def storage_class
      @storage_class ||= configuration.storage_class || "#{namespace}::Storage".constantize
    end

    # if behavior is names trole, namespace becomes Troles
    def namespace
      name.to_s.camelize
    end
  end
end