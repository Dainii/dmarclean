# frozen_string_literal: true

class FeedbackUploadsController < ApplicationController
  # GET /feedback_uploads/new
  def new
    @feedback_upload = FeedbackUpload.new
  end

  # GET /feedback_uploads/1/edit
  def edit; end

  # POST /feedback_uploads
  def create
    @feedback_upload = FeedbackUpload.new(feedback_upload_params)

    if @feedback_upload.save
      redirect_to new_feedback_upload_path, notice: 'Archvies uploaded'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def feedback_upload_params
    params.require(:feedback_upload).permit(archives: [])
  end
end
