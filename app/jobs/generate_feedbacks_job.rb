# frozen_string_literal: true

class GenerateFeedbacksJob < BaseJob
  def name
    'Generate process report job'
  end

  def perform(feedback_upload)
    feedback_upload.archives.each do |archive|
      archive.open do |opened_archive|
        feedback = Feedback.create!(
          report: {
            io: opened_archive,
            filename: archive.filename.to_s
          }
        )
        ProcessReportJob.perform_later(feedback)
      end
    end
  end
end
