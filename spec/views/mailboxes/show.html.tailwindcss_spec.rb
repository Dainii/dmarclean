# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'mailboxes/show' do
  before do
    assign(:testform, Mailbox.create!(
                        name: 'Name',
                        num: 2,
                        lol: false
                      ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
  end
end
