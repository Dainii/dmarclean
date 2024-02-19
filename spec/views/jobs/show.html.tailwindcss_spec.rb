# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'jobs/show' do
  before do
    assign(:job, Job.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
