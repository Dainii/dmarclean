# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

feedback = Feedback.create!(
  report: {
    io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
    filename: 'report_google.com.xml'
  }
)
Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)

feedback = Feedback.create!(
  report: {
    io: Rails.root.join('spec', 'examples', 'reports', 'report_outlook.com.xml').open,
    filename: 'report_outlook.com.xml'
  }
)
Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)

feedback = Feedback.create!(
  report: {
    io: Rails.root.join('spec', 'examples', 'reports', 'report_infomaniak.com.xml').open,
    filename: 'report_infomaniak.com.xml'
  }
)
Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)

feedback = Feedback.create!(
  report: {
    io: Rails.root.join('spec', 'examples', 'reports', 'google.com_domain.test.zip').open,
    filename: 'google.com_domain.test.zip'
  }
)
Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)

feedback = Feedback.create!(
  report: {
    io: Rails.root.join('spec', 'examples', 'reports', 'protection.outlook.com_domain.test.xml.gz').open,
    filename: 'protection.outlook.com_domain.test.xml.gz'
  }
)
Job.create!(job_id: ProcessReportJob.perform_later(feedback).job_id)
