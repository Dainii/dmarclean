# frozen_string_literal: true

class PtrController < AuthenticatedController
  # Get /ptr/1
  def show
    @ip_addres = params[:id]
    @ptr = Ptr.resolve(params[:id])
    render layout: false
  end
end
