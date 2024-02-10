# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'domains/index' do
  before do
    assign(:domains, Domain.all)
  end

  it 'renders a list of domains' do
    render
    expect(rendered).to include('domain2.test')
  end
end
