# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'domains/index' do
  before do
    assign(:domains, [Domain.create!(name: 'view.domain')])
  end

  it 'renders a list of domains' do
    render
    expect(rendered).to include('view.domain')
  end
end
