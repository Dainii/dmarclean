# frozen_string_literal: true

require 'mail'

class Mailbox < ApplicationRecord
  encrypts :password

  validates :mail_address, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def fetch_reports
    retrieve_mails.each do |mail|
      next if mail.attachments.empty?

      mail.attachments.each do |attachment|
        feedback = Feedback.create(
          report: {
            io: StringIO.new(attachment.decoded),
            filename: attachment.filename
          }
        )
        ProcessReportJob.perform_later(feedback)
      end
    end
  end

  private

  def retrieve_mails
    imap = Mail::IMAP.new(
      {
        address: server,
        port:,
        user_name: mail_address,
        password:,
        enable_ssl: !disable_ssl_tls
      }
    )

    # TODO: Maybe it's better to store the mail localy once downloaded
    # and before analyzing them. In case of a crash or a bug
    imap.find_and_delete(what: :first, count: 10, order: :asc)
  end
end
