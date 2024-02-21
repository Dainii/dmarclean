# frozen_string_literal: true

class ProcessReportJob < BaseJob
  def name
    'Process report'
  end

  def perform(feedback)
    feedback.extract_report

    return if feedback.raw_content.empty?

    feedback.extract_data

    feedback.update(processed: true)
  end
end
