# frozen_string_literal: true

class Job < ApplicationRecord
  validates :job_id, uniqueness: true

  belongs_to :solid_queue_job, class_name: 'SolidQueue::Job'

  def status
    ActiveJob::Status.get(job_id)
  end
end
