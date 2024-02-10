# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mailbox do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:mail_address) }
  end
end
