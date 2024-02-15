# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'domains/show' do
  before do
    assign(:domain, Domain.create!(name: 'view_show.domain'))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to include('view_show.domain')
  end
end
