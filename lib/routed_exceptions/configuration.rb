require 'routed_exceptions/selective_debug'
require 'routed_exceptions/selective_public'

module RoutedExceptions
  class Configuration
    attr_accessor :non_fatal_routing_errors,
                  :in_app_errors,
                  :application_config

    def initialize(application_config)
      @application_config       = application_config
      @non_fatal_routing_errors = false
      @in_app_errors            = []
    end

    def non_fatal_routing_errors=(active)
      @non_fatal_routing_errors = active

      if active
        application_config.middleware.swap ActionDispatch::DebugExceptions,
                                           SelectiveDebug
      else
        application_config.middleware.swap SelectiveDebug,
                                           ActionDispatch::DebugExceptions
      end
    end

    def in_app_errors=(codes)
      @in_app_errors = Array(codes)

      if @in_app_errors.empty?
        noisy_exceptions
      else
        silent_exceptions
      end
    end

    private

    def exceptions_app=(debugger)
      application_config.exceptions_app = debugger
    end

    def silent_exceptions
      self.exceptions_app = RoutedExceptions::SelectivePublic.new(Rails.public_path)
    end

    def noisy_exceptions
      self.exceptions_app = ActionDispatch::DebugExceptions.new(Rails.public_path)
    end
  end
end
