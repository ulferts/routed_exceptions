require 'action_dispatch/middleware/public_exceptions'

module RoutedExceptions
  class SelectivePublic
    attr_accessor :default_handler,
                  :rails_application

    def initialize(path)
      @default_handler = ActionDispatch::PublicExceptions.new(path)
      @rails_application = Rails.application

      self
    end

    def call(env)
      if routed_error?(env)
        rails_application.routes.call env
      else
        default_handler.call(env)
      end
    end

    private

    def routed_error?(env)
      routed_errors.include?(status(env))
    end

    def status(env)
      env['PATH_INFO'][1..-1]
    end

    def routed_errors
      rails_application.config.routed_exceptions.in_app_errors
    end
  end
end
