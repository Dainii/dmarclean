# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[show]

  # GET /jobs
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end
end
