# frozen_string_literal: true

class ProcessReportJob < ApplicationJob
  queue_as :default

  def perform(feedback)
    # Parse the XML report and save it as json
    feedback.raw_content = JSON.parse(Crack::XML.parse(feedback.report.download).to_json)
    feedback.save

    return unless feedback.persisted?

    feedback.report_id = feedback.raw_content['feedback']['report_metadata']['report_id'].to_f

    feedback.begin_date = Time.at(feedback.raw_content['feedback']['report_metadata']['date_range']['begin'].to_i).utc
    feedback.end_date = Time.at(feedback.raw_content['feedback']['report_metadata']['date_range']['end'].to_i).utc

    feedback.organization = Organization.find_or_create_by(
      name: feedback.raw_content['feedback']['report_metadata']['org_name']
    )

    feedback.domain = Domain.find_or_create_by(
      name: feedback.raw_content['feedback']['policy_published']['domain']
    )

    feedback.processed = true

    feedback.save
  end
end
