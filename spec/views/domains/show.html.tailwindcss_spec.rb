# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'domains/show' do
  let(:feedback) do
    Feedback.create!(
      report: {
        io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
        filename: 'report_google.com.xml'
      }
    )
  end

  before do
    feedback.extract_report
    feedback.extract_data

    assign(:domain, feedback.domain)

    render
  end

  context 'with the rendered page' do
    it { expect(rendered).to include('google.com') }
  end
end
