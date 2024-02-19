# frozen_string_literal: true

class GenerateFeedbacksJob < BaseJob
  def perform(feedback_upload)
    feedback_upload.archives.each do |archive|
      archive.open do |opened_archive|
        feedback = Feedback.create!(
          report: {
            io: opened_archive,
            filename: archive.filename.to_s
          }
        )
        Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)
      end
    end
  end
end
