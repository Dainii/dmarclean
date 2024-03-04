# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/show' do
  before do
    assign(
      :mailbox,
      Mailbox.create!(
        mail_address: 'mail@domain.test',
        server: 'imap@domain.test',
        port: 465,
        verify_ssl: true,
        disable_ssl_tls: false
      )
    )
  end

  describe 'renders attributes in <p>' do
    render

    it { expect(rendered).to match(/Address/) }
    it { expect(rendered).to match(/Server/) }
    it { expect(rendered).to match(/Port/) }
  end
end
