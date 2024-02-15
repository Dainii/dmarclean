# frozen_string_literal: true

class ProcessReportJob < ApplicationJob
  queue_as :default

  def perform(feedback)
    feedback.parse_xml_report

    return if feedback.raw_content.empty?

    feedback.extract_data

    feedback.processed = true
    feedback.save
  end
end
