# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/new' do
  before do
    assign(:testform, Mailbox.new(
                        name: 'MyString',
                        num: 1,
                        lol: false
                      ))
  end

  it 'renders new mailbox form' do
    render

    assert_select 'form[action=?][method=?]', mailboxes_path, 'post' do
      assert_select 'input[name=?]', 'testform[name]'

      assert_select 'input[name=?]', 'testform[num]'

      assert_select 'input[name=?]', 'testform[lol]'
    end
  end
end
