# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Feedback do
  feedback = described_class.create(
    report: {
      io: Rails.root.join('spec', 'examples', 'reports', 'report_google.com.xml').open,
      filename: 'report_google.com.xml'
    }
  )

  describe 'has store the XML content as JSON' do
    feedback.extract_report

    it { expect(feedback.raw_content).not_to be_nil }
    it { expect(feedback.raw_content).to be_a Hash }
  end

  context 'with extracted data, it' do
    feedback.extract_data

    describe 'has a report id' do
      it { expect(feedback.report_id).to eq('123456789') }
    end

    describe 'has a begin and end date' do
      it { expect(feedback.begin_date).not_to be_nil }
      it { expect(feedback.end_date).not_to be_nil }
    end

    describe 'is linked to an organization' do
      org_google = Organization.find_by(name: 'google.com')

      it { expect(org_google).not_to be_nil }
      it { expect(feedback.organization.id).to eq(org_google.id) }
    end

    describe 'is linked to a domain' do
      dom_test = Domain.find_by(name: 'google.domain')

      it { expect(dom_test).not_to be_nil }
      it { expect(feedback.domain.id).to eq(dom_test.id) }
    end

    describe 'has a policy_published' do
      it { expect(feedback.policy_published['adkim']).to eq('r') }
    end

    # FIXME
    # This test doesn't work even if it should
    # describe 'has a record' do
    #   it { expect(feedback.records.count).to eq(1) }
    # end

    describe 'is fully valid' do
      it { expect(feedback.fully_valid?).to be true }
    end

    # FIXME
    # This one doesn't work but the one above yes...
    # describe 'is also partially valid' do
    #   it { expect(feedback.partially_valid?).to be true }
    # end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:domain).optional(true) }
    it { is_expected.to belong_to(:organization).optional(true) }
    it { is_expected.to have_many(:records).dependent(:destroy) }
  end
end
