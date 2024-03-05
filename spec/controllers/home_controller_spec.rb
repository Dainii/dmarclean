# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController do
  context 'with an unauthenticated user' do
    describe 'GET /' do
      before do
        get :index
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

    describe 'GET /' do
      before do
        get :index
      end

      it { is_expected.to respond_with(200) }
    end
  end

  # TODO
  # The below tests are design to test the `switch_locale` method defined in `ApplicationController`
  # It should probably be elsewhere
  context 'with render_views as authenticated user' do
    render_views

    let(:account) { Account.create!(email: 'user@example.com', password: 'secret123', status: 2) }

    before do
      sign_in(account)
    end

    def sign_in(account)
      @controller.rodauth.account_from_login(account.email) # rubocop:disable RSpec/InstanceVariable
      @controller.rodauth.login_session('secret123') # rubocop:disable RSpec/InstanceVariable
    end

    describe 'GET / with en-US locale' do
      before do
        request.headers['HTTP_ACCEPT_LANGUAGE'] = 'en-US,en;q=0.5'
        get :index
      end

      it { expect(response.body).to match(%r{<a href="/domains">Domains</a>}) }
    end

    describe 'GET / with fr-FR locale' do
      before do
        request.headers['HTTP_ACCEPT_LANGUAGE'] = 'fr-FR,fr;q=0.5'
        get :index
      end

      it { expect(response.body).to match(%r{<a href="/domains">Domaines</a>}) }
    end

    describe 'GET / with unknown locale' do
      before do
        request.headers['HTTP_ACCEPT_LANGUAGE'] = 'as-XD,as;q=0.5'
        get :index
      end

      it { expect(response.body).to match(%r{<a href="/domains">Domains</a>}) }
    end
  end
end
