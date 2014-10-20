require 'spec_helper'
require 'rails/engine/railties'
require 'rails/engine'
require 'rails/application'

describe RoutedExceptions::RailsConfigurationPatch do
  subject(:config) { Mock::Application.config.routed_exceptions }

  it 'adds a routed_exceptions configuration' do
    is_expected.to be_a(RoutedExceptions::Configuration)
  end
end
