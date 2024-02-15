# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/index' do
  before do
    assign(:mailboxes, [
             Mailbox.create!(
               name: 'Name',
               num: 2,
               lol: false
             ),
             Mailbox.create!(
               name: 'Name',
               num: 2,
               lol: false
             )
           ])
  end

  it 'renders a list of testforms' do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new('Name'.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(2.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(false.to_s), count: 2
  end
end
