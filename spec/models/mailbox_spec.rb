# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mailbox do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:mail_address) }
    it { is_expected.to allow_value('mail@domain.test').for(:mail_address) }
    it { is_expected.not_to allow_value('mail.domain.test').for(:mail_address) }
  end
end
