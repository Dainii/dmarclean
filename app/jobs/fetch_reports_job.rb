# frozen_string_literal: true

class FetchReportsJob < BaseJob
  def name
    'Fetch reports from mailbox'
  end

  def perform
    Mailbox.all(&:fetch_reports)
  end
end
