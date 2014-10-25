require 'spec_helper'
require 'routed_exceptions/selective_debug'

describe RoutedExceptions::SelectiveDebug do
  let(:app) do
    app = double('app').as_null_object

    allow(app).to receive(:call).and_raise(exception, 'blubs')

    app
  end

  let(:logger) { double('logger').as_null_object }
  let(:env) do

    neutral = double('neutral').as_null_object
    env = double('env').as_null_object

    allow(env).to receive(:[])
              .and_return(neutral)

    allow(env).to receive(:[])
              .with('action_dispatch.logger')
              .and_return(logger)

    allow(env).to receive(:[])
              .with('action_dispatch.show_detailed_exceptions')
              .and_return(true)

    env
  end

  let(:instance) { RoutedExceptions::SelectiveDebug.new(app, nil) }

  describe :call do

    context 'an AbstractController::ActionNotFound exception' do
      let(:exception) { AbstractController::ActionNotFound }

      it 'does not trigger logger' do
        expect(logger).to_not receive(:fatal)

        instance.call(env)
      end
    end

    context 'an ActionController::RoutingError exception' do
      let(:exception) { ActionController::RoutingError }

      it 'does not trigger logger' do
        expect(logger).to_not receive(:fatal)

        instance.call(env)
      end
    end

  end
end
