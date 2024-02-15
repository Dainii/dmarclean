# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProcessReportJob do
  describe 'Process XML report' do
    ActiveJob::Base.queue_adapter = :test

    feedback = Feedback.create(
      report: {
        io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
        filename: 'report_google.com.xml'
      }
    )
    described_class.perform_later(feedback)

    it { expect { described_class.perform_later('feedback') }.to have_enqueued_job }
  end
end
