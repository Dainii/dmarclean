# frozen_string_literal: true

class JobsController < AuthenticatedController
  before_action :set_job, only: %i[show]

  # GET /jobs
  def index
    @jobs = Job.includes(:solid_queue_job).all
  end

  # GET /jobs/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.includes(:solid_queue_job).find(params[:id])
  end
end
