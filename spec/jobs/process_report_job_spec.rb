# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessReportJob do
  describe 'Process XML report' do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

    feedback = Feedback.first
    described_class.perform_later(feedback)

    it do
      expect(described_class).to(
        have_been_performed.with(feedback)
      )
    end

    feedback.reload

    describe 'has store the XML content as JSON' do
      it { expect(feedback.raw_content).not_to be_nil }
      it { expect(feedback.raw_content).to be_a Hash }
    end

    describe 'has a report id' do
      it { expect(feedback.report_id).to eq(123_456_789.0) }
    end

    describe 'has a begin and end date' do
      it { expect(feedback.begin_date).not_to be_nil }
      it { expect(feedback.end_date).not_to be_nil }
    end

    describe 'is linked to an organization' do
      org_google = Organization.find_by(name: 'google.com')
      org_feedback = feedback.organization

      it { expect(org_google).not_to be_nil }
      it { expect(org_feedback.id).to eq(org_google.id) }
    end

    describe 'is linked to a domain' do
      dom_test = Domain.find_by(name: 'test.domain')
      dom_feedback = feedback.domain

      it { expect(dom_test).not_to be_nil }
      it { expect(dom_feedback.id).to eq(dom_test.id) }
    end

    describe 'is mark as processed' do
      it { expect(feedback.processed).to be true }
    end
  end
end
