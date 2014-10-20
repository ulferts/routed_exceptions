require 'spec_helper'
require 'routed_exceptions/configuration'

describe RoutedExceptions::Configuration do
  let(:app_config) { Mock::Application.config }
  let(:instance) { described_class.new(app_config) }

  describe '#in_app_errors' do
    let(:subject) { instance.in_app_errors }

    it 'is initialized with an empty array' do
      is_expected.to match_array []
    end

    context 'set to value' do
      it 'casts into array when string provided' do
        instance.in_app_errors = '404'

        is_expected.to match_array %w( 404 )
      end

      it 'can be set an array of values' do
        instance.in_app_errors = %w( 404 500 )

        is_expected.to match_array %w( 404 500 )
      end

      it 'sets the exception_app of the rails config to SelectivePublic' do
        instance.in_app_errors = '404'

        expect(app_config.exceptions_app).to be_a RoutedExceptions::SelectivePublic
      end
    end

    context 'set to nil' do
      it 'sets the exception_app of the rails config to the rails default' do
        instance.in_app_errors = nil

        expect(app_config.exceptions_app).to be_a ActionDispatch::DebugExceptions
      end
    end
  end

  describe '#non_fatal_routing_errors' do
    let(:subject) { instance.non_fatal_routing_errors }

    it 'is initialized to false' do
      is_expected.to be_falsy
    end

    context 'set to true' do
      it 'is true' do
        instance.non_fatal_routing_errors = true
        is_expected.to be_truthy
      end

      it 'swaps the middleware used for exception debugging' do
        expect(app_config.middleware).to receive(:swap).with(ActionDispatch::DebugExceptions, RoutedExceptions::SelectiveDebug)
        instance.non_fatal_routing_errors = true
      end
    end

    context 'set to false' do
      it 'is false' do
        instance.non_fatal_routing_errors = false
        is_expected.to be_falsy
      end

      it 'swaps the middleware used for exception debugging' do
        expect(app_config.middleware).to receive(:swap).with(RoutedExceptions::SelectiveDebug, ActionDispatch::DebugExceptions)
        instance.non_fatal_routing_errors = false
      end
    end
  end
end
