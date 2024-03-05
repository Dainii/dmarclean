# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MailboxesController do
  context 'with an unauthenticated user' do
    let(:mailbox) do
      Mailbox.create!(
        mail_address: 'dmarc@mailbox.test',
        password: 'Password,123',
        server: 'mytestserver.mailbox.test',
        port: 25,
        verify_ssl: true,
        disable_ssl_tls: false
      )
    end

    describe 'GET /' do
      before do
        get :index
      end

      it { is_expected.to respond_with(302) }
    end

    describe 'GET /mailboxes/:id' do
      before do
        get :show, params: { id: mailbox.id }
      end

      it { is_expected.to respond_with(302) }
    end
  end

  context 'with an authenticated user' do
    let(:account) { Account.create!(email: 'user@example.com', password: 'secret123', status: 2) }
    let(:mailbox) do
      Mailbox.create!(
        mail_address: 'dmarc@mailbox.test',
        password: 'Password,123',
        server: 'mytestserver.mailbox.test',
        port: 25,
        verify_ssl: true,
        disable_ssl_tls: false
      )
    end

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

    describe 'GET /mailboxs/:id' do
      before do
        get :show, params: { id: mailbox.id }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to use_before_action(:set_mailbox) }
    end

    describe 'GET /mailboxes/new' do
      before do
        get :new
      end

      it { is_expected.to respond_with(200) }
    end

    describe 'GET /mailboxs/:id/edit' do
      before do
        get :edit, params: { id: mailbox.id }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to use_before_action(:set_mailbox) }
    end

    describe 'POST /mailboxes' do
      context 'with valid params' do
        before do
          params = {
            mail_address: 'dmarc2@mailbox.test',
            password: 'Password,123',
            server: 'mytestserver.mailbox.test',
            port: 25,
            verify_ssl: true,
            disable_ssl_tls: false
          }
          post :create, params: { mailbox: params }
        end

        it { is_expected.to respond_with(302) }
        it { expect(Mailbox.last.mail_address).to eq('dmarc2@mailbox.test') }
      end

      context 'with invalid params' do
        before do
          params = {
            mail_address: 'mailbox.test',
            password: 'Password,123',
            server: 'mytestserver.mailbox.test',
            port: 25,
            verify_ssl: true,
            disable_ssl_tls: false
          }
          post :create, params: { mailbox: params }
        end

        it { is_expected.to respond_with(422) }
        # FIXME
        # Mailbox.last returns nil, but it should return the Mailbox create on line 7
        # it { expect(Mailbox.last.mail_address).not_to eq('mailbox.test') }
      end
    end

    describe 'PATCH/PUT /mailboxes/:id' do
      context 'with valid params' do
        before do
          patch :update, params: { id: mailbox.id, mailbox: { server: 'myupdatedserver.mailbox.test' } }
        end

        it { is_expected.to respond_with(303) }
        it { is_expected.to use_before_action(:set_mailbox) }
        it { expect(Mailbox.find(mailbox.id).server).to eq('myupdatedserver.mailbox.test') }
      end

      context 'with invalid params' do
        before do
          patch :update, params: { id: mailbox.id, mailbox: { mail_address: 'mailbox.test' } }
        end

        it { is_expected.to respond_with(422) }
        it { is_expected.to use_before_action(:set_mailbox) }
        it { expect(Mailbox.find(mailbox.id).mail_address).not_to eq('mailbox.test') }
      end
    end

    describe 'DELETE /mailboxes/:id' do
      before do
        delete :destroy, params: { id: mailbox.id }
      end

      it { is_expected.to respond_with(303) }
      it { is_expected.to use_before_action(:set_mailbox) }
      it { expect(Mailbox.exists?(mailbox.id)).not_to be true }
    end
  end
end
