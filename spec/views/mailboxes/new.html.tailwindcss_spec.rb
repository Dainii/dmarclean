# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/new' do
  before do
    assign(
      :mailbox,
      Mailbox.create!(
        mail_address: 'mail@domain.test',
        password: 'password',
        server: 'imap@domain.test',
        port: 465,
        verify_ssl: true,
        disable_ssl_tls: false
      )
    )
  end

  it 'renders new mailbox form' do
    render

    assert_select 'form[action=?][method=?]', mailboxes_path, 'post' do
      assert_select 'input[name=?]', 'mailbox[mail_address]'
      assert_select 'input[name=?]', 'mailbox[password]'
      assert_select 'input[name=?]', 'mailbox[server]'
      assert_select 'input[name=?]', 'mailbox[port]'
      assert_select 'input[name=?]', 'mailbox[verify_ssl]'
      assert_select 'input[name=?]', 'mailbox[disable_ssl_tls]'
    end
  end
end
