# frozen_string_literal: true

class FeedbacksController < AuthenticatedController
  before_action :set_feedback, only: %i[show]

  # Get /domains/1/feedbacks/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_feedback
    @feedback = Feedback.includes(:domain, :records).find(params[:id])
  end
end
