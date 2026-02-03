# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::Paginatable do
  subject(:controller) { dummy_controller.new(params) }

  let(:dummy_controller) do
    Class.new do
      include Api::Paginatable

      attr_accessor :params

      def initialize(params = {})
        @params = params
      end

      def pagy(scope, page:, limit:) # rubocop:disable Lint/UnusedMethodArgument
        [:pagy_object, scope.first(limit)]
      end
    end
  end

  let(:scope) { (1..20).to_a }

  describe '#paginate' do
    context 'without params' do
      let(:params) { {} }

      it 'uses default page and limit' do
        pagy, records = controller.send(:paginate, scope)

        expect(pagy).to eq(:pagy_object)
        expect(records.size).to eq(9)
      end
    end

    context 'with custom limit and page' do
      let(:params) { { limit: '5', page: '2' } }

      it 'passes params to pagy' do
        expect(controller).to receive(:pagy) # rubocop:disable RSpec/StubbedMock,RSpec/SubjectStub,RSpec/MessageSpies
          .with(scope, page: 2, limit: 5)
          .and_return([:pagy_object, scope[5, 5]])

        controller.send(:paginate, scope)
      end
    end

    context 'when page=all' do
      let(:params) { { page: 'all' } }

      it 'returns full scope without pagy' do
        pagy, records = controller.send(:paginate, scope)

        expect(pagy).to be_nil
        expect(records).to eq(scope)
      end
    end

    context 'with invalid params' do
      let(:params) { { limit: '0', page: '-3' } }

      it 'falls back to defaults' do
        _pagy, records = controller.send(:paginate, scope)

        expect(records.size).to eq(9)
      end
    end
  end
end
