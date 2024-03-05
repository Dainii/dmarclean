# frozen_string_literal: true

class BaseJob < ApplicationJob
  include ActiveJob::Status

  queue_as :default

  after_enqueue do |job|
    Job.create(
      job_id: job.job_id,
      name:,
      solid_queue_job: SolidQueue::Job.find_by(active_job_id: job.job_id)
    )
  end

  def name
    'Undefined'
  end

  def perform; end
end
