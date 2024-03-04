# frozen_string_literal: true

class MailboxesController < AuthenticatedController
  before_action :set_mailbox, only: %i[show edit update destroy]

  # GET /mailboxes
  def index
    @mailboxes = Mailbox.all
  end

  # GET /mailboxes/1
  def show; end

  # GET /mailboxes/new
  def new
    @mailbox = Mailbox.new
  end

  # GET /mailboxes/1/edit
  def edit; end

  # POST /mailboxes
  def create
    @mailbox = Mailbox.new(mailbox_params)

    if @mailbox.save
      redirect_to @mailbox, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /mailboxes/1
  def update
    if @mailbox.update(mailbox_params)
      redirect_to @mailbox, notice: t('.success'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /mailboxes/1
  def destroy
    @mailbox.destroy!
    redirect_to mailboxes_url, notice: t('.success'), status: :see_other
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_mailbox
    @mailbox = Mailbox.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def mailbox_params
    params.require(:mailbox).permit(:mail_address, :password, :server, :port, :verify_ssl, :disable_ssl_tls)
  end
end
