# frozen_string_literal: true

class Mailbox < ApplicationRecord
  encrypts :password

  validates :mail_address, presence: true
end
