# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbacksController do
  context 'with an unauthenticated user' do
    let(:domain) { Domain.create!(name: 'controller.domain') }
    let(:feedback) { Feedback.create!(domain:) }

    describe 'GET /domains/:domain_id/feedbacks/:id' do
      before do
        get :show, params: { domain_id: domain.id, id: feedback.id }
      end

      it { is_expected.to respond_with(302) }
      it { is_expected.to use_before_action(:set_feedback) }
    end
  end

  context 'with an authenticated user' do
    let(:account) { Account.create!(email: 'user@example.com', password: 'secret123', status: 2) }
    let(:domain) { Domain.create!(name: 'controller.domain') }
    let(:feedback) { Feedback.create!(domain:) }

    before do
      sign_in(account)
    end

    def sign_in(account)
      @controller.rodauth.account_from_login(account.email) # rubocop:disable RSpec/InstanceVariable
      @controller.rodauth.login_session('secret123') # rubocop:disable RSpec/InstanceVariable
    end

    describe 'GET /domains/:domain_id/feedbacks/:id' do
      before do
        get :show, params: { domain_id: domain.id, id: feedback.id }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to use_before_action(:set_feedback) }
    end
  end
end
