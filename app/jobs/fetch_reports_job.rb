# frozen_string_literal: true

class FetchReportsJob < BaseJob
  def perform
    Mailbox.all(&:fetch_reports)
  end
end
