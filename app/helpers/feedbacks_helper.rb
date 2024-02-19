# frozen_string_literal: true

module FeedbacksHelper
  def source_ip_list(feedback)
    records = feedback.records
    record_count = records.length

    return records.first.source_ip if record_count == 1

    "#{records.first.source_ip} + #{record_count - 1} others IP"
  end
end
