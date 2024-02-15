# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/edit' do
  let(:mailbox) do
    Mailbox.create!
  end

  before do
    assign(:mailbox, mailbox)
  end

  it 'renders the edit mailbox form' do
    render

    assert_select 'form[action=?][method=?]', mailbox_path(mailbox), 'post' do
      assert_select 'input[name=?]', 'testform[name]'

      assert_select 'input[name=?]', 'testform[num]'

      assert_select 'input[name=?]', 'testform[lol]'
    end
  end
end
