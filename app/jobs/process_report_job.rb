# frozen_string_literal: true

class ProcessReportJob < BaseJob
  def perform(feedback)
    feedback.extract_report

    return if feedback.raw_content.empty?

    feedback.extract_data

    feedback.processed = true
    feedback.save
  end
end
