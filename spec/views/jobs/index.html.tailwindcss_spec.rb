# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'jobs/index' do
  before do
    assign(:jobs, [
             Job.create!,
             Job.create!
           ])
  end

  it 'renders a list of jobs' do
    render
    Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
  end
end
