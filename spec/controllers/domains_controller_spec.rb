# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DomainsController do
  context 'with an unauthenticated user' do
    describe 'GET /' do
      before do
        get :index
      end

      it { is_expected.to respond_with(302) }
    end

    describe 'GET /domains/:id' do
      before do
        get :show, params: { id: Domain.create!(name: 'controller.domain').id }
      end

      it { is_expected.to respond_with(302) }
      it { is_expected.to use_before_action(:set_domain) }
    end
  end
end
