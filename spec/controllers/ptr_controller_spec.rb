# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PtrController do
  context 'with an unauthenticated user' do
    describe 'GET /ptr/:id' do
      before do
        get :show, params: { id: '9.9.9.9' }
      end

      it { is_expected.to respond_with(302) }
    end
  end

  context 'with an authenticated user' do
    let(:account) { Account.create!(email: 'user@example.com', password: 'secret123', status: 2) }

    before do
      sign_in(account)
    end

    def sign_in(account)
      @controller.rodauth.account_from_login(account.email) # rubocop:disable RSpec/InstanceVariable
      @controller.rodauth.login_session('secret123') # rubocop:disable RSpec/InstanceVariable
    end

    describe 'GET /ptr/:id' do
      before do
        get :show, params: { id: '9.9.9.9' }
      end

      it { is_expected.to respond_with(200) }
    end
  end
end
