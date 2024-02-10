# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'domains/show' do
  before do
    assign(:domain, Domain.first)
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to include('domain2.test')
  end
end
