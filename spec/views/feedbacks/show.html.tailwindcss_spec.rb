# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'feedbacks/show' do
  before do
    feedback = Feedback.create!(
      report: {
        io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
        filename: 'report_google.com.xml'
      }
    )
    feedback.extract_report
    feedback.extract_data

    assign(:feedback, feedback)

    render
  end

  context 'with a rendered page' do
    it { expect(rendered).to include('123456789') }
  end
end
