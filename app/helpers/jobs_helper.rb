# frozen_string_literal: true

module JobsHelper
  def job_status(status)
    status.status.nil? ? 'Unknown' : status.status.to_s
  end
end
