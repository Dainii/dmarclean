# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/index' do
  before do
    assign(
      :mailboxes,
      [
        Mailbox.create!(
          mail_address: 'mail@domain.test',
          server: 'imap@domain.test',
          port: 465,
          verify_ssl: true,
          disable_ssl_tls: false
        ),
        Mailbox.create!(
          mail_address: 'mail@domain2.test',
          server: 'imap@domain2.test',
          port: 465,
          verify_ssl: true,
          disable_ssl_tls: false
        )
      ]
    )
  end

  it 'renders a list of testforms' do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new('Address'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new('Server'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(465.to_s), count: 2
  end
end
