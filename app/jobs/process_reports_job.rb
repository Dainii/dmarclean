# frozen_string_literal: true

class ProcessReportsJob < ApplicationJob
  queue_as :default

  def perform
    Feedback.where(processed: false).find_each { |feedback| ProcessReportJob.perform_later(feedback) }
  end
end
