# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FeedbackUploadsController do
  context 'with an unauthenticated user' do
    describe 'GET /feedback_uploads/new' do
      before do
        get :new
      end

      it { is_expected.to respond_with(302) }
    end

    describe 'POST /feedback_uploads' do
      context 'with valid params' do
        before do
          post :create, params: {
            archives: file_fixture_upload(
              Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml'),
              'text/xml'
            )
          }
        end

        it { is_expected.to respond_with(302) }
      end
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

    describe 'GET /feedback_uploads/new' do
      before do
        get :new
      end

      it { is_expected.to respond_with(200) }
    end

    describe 'POST /feedback_uploads' do
      context 'with valid params' do
        before do
          post :create, params: {
            feedback_upload: {
              archives: file_fixture_upload(
                Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml'),
                'text/xml'
              )
            }
          }
        end

        it { is_expected.to respond_with(302) }
      end
    end
  end
end
