require 'action_dispatch'
require 'action_dispatch/middleware/debug_exceptions'
require 'abstract_controller'
require 'abstract_controller/base'
require 'action_view'

module RoutedExceptions
  class SelectiveDebug < ActionDispatch::DebugExceptions

    private

    def log_error(env, wrapper)
      exception = wrapper.exception

      super unless logging_disabled?(exception)
    end

    def logging_disabled?(exception)
      disabled_exceptions.any? do |klass|
        exception.is_a?(klass)
      end
    end

    def disabled_exceptions
      [::AbstractController::ActionNotFound,
       ::ActionController::RoutingError]
    end
  end
end
