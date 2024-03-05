# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobsController do
  context 'with an unauthenticated user' do
    let(:job) do
      sq_job = SolidQueue::Job.create(queue_name: 'default', class_name: 'BaseJob')

      Job.create!(
        job_id: '123456789',
        name: 'test job',
        solid_queue_job: sq_job
      )
    end

    describe 'GET /jobs' do
      before do
        get :index
      end

      it { is_expected.to respond_with(302) }
    end

    describe 'GET /jobs/:id' do
      before do
        get :show, params: { id: job.id }
      end

      it { is_expected.to respond_with(302) }
      it { is_expected.to use_before_action(:set_job) }
    end
  end

  context 'with an authenticated user' do
    let(:job) do
      sq_job = SolidQueue::Job.create(queue_name: 'default', class_name: 'BaseJob')

      Job.create!(
        job_id: '123456789',
        name: 'test job',
        solid_queue_job: sq_job
      )
    end
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

    describe 'GET /jobs/:id' do
      before do
        get :show, params: { id: job.id }
      end

      it { is_expected.to respond_with(200) }
      it { is_expected.to use_before_action(:set_job) }
    end
  end
end
