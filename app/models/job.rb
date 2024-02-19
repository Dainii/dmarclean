# frozen_string_literal: true

class Job < ApplicationRecord
  validates :job_id, uniqueness: true

  def status
    ActiveJob::Status.get(job_id)
  end
end
