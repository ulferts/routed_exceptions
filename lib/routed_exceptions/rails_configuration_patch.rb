module RoutedExceptions
  module RailsConfigurationPatch
    def self.included(base)
      base.include(InstanceMethods)
    end

    module InstanceMethods
      def routed_exceptions
        @routed_exceptions_config ||= ::RoutedExceptions::Configuration.new(self)
      end
    end
  end
end

unless Rails::Application::Configuration
        .included_modules.include?(RoutedExceptions::RailsConfigurationPatch)
  Rails::Application::Configuration.include(RoutedExceptions::RailsConfigurationPatch)
end
