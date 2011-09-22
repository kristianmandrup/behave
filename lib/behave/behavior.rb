module Behave
  class Behavior
    attr_reader :name, :subject_class, :configuration_class, :options

    # set classes to use for config, storage etc, also set general options
    # Example:
    #   Behave::Behavior.new :troles, subject_class, configuration_class, :message => 'hello'
    #
    # @param [Hash] class hash
    #
    def initialize name, subject_class, configuration_class, options = {}
      raise ArgumentError, "A behavior must have a name" if !name && !name.kind_of_label?
      raise ArgumentError, "A behavior must have a subject class" if !subject_class
      raise ArgumentError, "A behavior must have configuration class of type Class" if !configuration_class && !configuration_class.kind_of?(Class)

      @name = name
      @subject_class = subject_class
      @configuration_class = configuration_class
      @options = options
    end

    def configuration
      @configuration ||= configuration_class.new name, subject_class, options
    end

    # configures the behavior for the specific subject class
    # what should really happen here?
    # what is the minimal list of things to do for any behavior, and what are the nice "add-ons" 
    # and how can we make a flexible hook-system for these?
    def configure_with strategy = :default, options = {}, &block
      configuration.strategy = strategy
      # use configuration to load adapter!
      configuration.load_adapter

      # apply options to config
      config.apply_options! options

      yield config if block_given?
      config
    end
    alias_method :configure!, :configure_with

    # apply the behavior to the subject
    def apply!
      # include the strategy module of the configuration directly on the subject, thus applying the API etc
      subject_class.send :include, configuration.strategy_module
      self
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
      @store ||= storage_class
    end

    protected

    # For behavior :troles, defaults to Troles::Config
    def config_class
      @config_class ||= configuration.config_class
    end

    # For behavior :troles, defaults to Troles::Storage
    def storage_class
      @storage_class ||= configuration.storage_class
    end

    # if behavior is names trole, namespace becomes Troles
    def namespace
      name.to_s.camelize
    end
  end
end
