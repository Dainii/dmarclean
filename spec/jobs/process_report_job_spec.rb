# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessReportJob do
  describe 'Process XML report' do
    ActiveJob::Base.queue_adapter = :test
    ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true

    let(:feedback) do
      Feedback.create(
        report: {
          io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
          filename: 'report_google.com.xml'
        }
      )
    end

    it do
      described_class.perform_later(feedback)
      expect(described_class).to(
        have_been_performed.with(feedback)
      )
    end
  end
end
