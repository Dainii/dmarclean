# frozen_string_literal: true

class DomainsController < AuthenticatedController
  before_action :set_domain, only: %i[show]

  # GET /domains
  def index
    @domains = Domain.all
  end

  # Get /domains/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_domain
    @domain = Domain.includes(feedbacks: %i[records organization]).find(params[:id])
  end
end
