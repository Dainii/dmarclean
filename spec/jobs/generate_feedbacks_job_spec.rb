# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GenerateFeedbacksJob do
  ActiveJob::Base.queue_adapter = :test

  it { expect { described_class.perform_later }.to have_enqueued_job }

  context 'when performed' do
    let(:feedback_upload) do
      FeedbackUpload.create!(
        archives: [
          {
            io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
            filename: 'report_google.com.xml'
          },
          {
            io: Rails.root.join('spec', 'examples', 'reports', 'report_outlook.com.xml').open,
            filename: 'report_outlook.com.xml'
          },
          {
            io: Rails.root.join('spec', 'examples', 'reports', 'report_infomaniak.com.xml').open,
            filename: 'report_infomaniak.com.xml'
          }
        ]
      )
    end

    before do
      ActiveJob::Base.queue_adapter.perform_enqueued_jobs = true
      described_class.perform_later(feedback_upload)
    end

    it { expect(Feedback.count).to eq(3) }

    it do
      expect(described_class).to(
        have_been_performed.with(feedback_upload)
      )
    end
  end
end
