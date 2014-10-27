require 'spec_helper'
require 'routed_exceptions/selective_public'

describe RoutedExceptions::SelectivePublic do
  let(:env) do
    env = double('env').as_null_object

    allow(env).to receive(:[])
              .with('PATH_INFO')
              .and_return("/#{status_code}")

    env
  end

  let(:rails_application) do
    application = double('rails_application').as_null_object
    config = double('config').as_null_object
    routed = double('routed_exceptions').as_null_object
    routes = double('routes').as_null_object

    allow(routed).to receive(:in_app_errors).and_return(Array(handled_errors))
    allow(config).to receive(:routed_exceptions).and_return(routed)
    allow(application).to receive(:config).and_return(config)
    allow(application).to receive(:routes).and_return(routes)

    application
  end

  let(:status_code) { 200 }
  let(:handled_errors) { [] }

  let(:default_handler) { double('default_handler').as_null_object }
  let(:instance) { RoutedExceptions::SelectivePublic.new('bogus') }

  before do
    instance.rails_application = rails_application
    instance.default_handler = default_handler
  end

  describe :call do
    context 'an 404 which is configured to be handled' do
      let(:status_code) { 404 }
      let(:handled_errors) { ['404'] }

      it 'call application routing' do
        expect(rails_application.routes).to receive(:call)
                                        .with(env)
        expect(default_handler).to_not receive(:call)
                               .with(env)

        instance.call(env)
      end
    end

    context 'an 404 which is not configured to be handled' do
      let(:status_code) { 404 }
      let(:handled_errors) { ['200'] }

      it 'call application routing' do
        expect(default_handler).to receive(:call)
                               .with(env)
        expect(rails_application.routes).to_not receive(:call)
                                        .with(env)

        instance.call(env)
      end
    end
  end
end
