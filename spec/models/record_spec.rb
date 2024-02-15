# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record do
  describe 'associations' do
    it { is_expected.to belong_to(:feedback) }
  end

  record_hash = {
    'row' => {
      'source_ip' => '12.34.56.78',
      'count' => '2',
      'policy_evaluated' => {
        'disposition' => 'none',
        'dkim' => 'pass',
        'spf' => 'pass'
      }
    },
    'identifiers' => {
      'header_from' => 'google.domain'
    },
    'auth_results' => {
      'dkim' => {
        'domain' => 'google.domain',
        'result' => 'pass',
        'selector' => 'pmg'
      },
      'spf' => {
        'domain' => 'google.domain',
        'result' => 'pass'
      }
    }
  }

  record = described_class.new(feedback: Feedback.create)

  context 'with extracted hash, it' do
    record.update_from_hash(record_hash)

    describe 'has a source_ip' do
      it { expect(record.source_ip).to eq('12.34.56.78') }
    end

    describe 'has a count' do
      it { expect(record.count).to eq(2) }
    end

    describe 'has a policy_evaluated' do
      it { expect(record.policy_evaluated).not_to be_empty }
    end

    describe 'has a identifiers' do
      it { expect(record.identifiers).not_to be_empty }
    end

    describe 'has a auth_results' do
      it { expect(record.auth_results).not_to be_empty }
    end

    describe 'has a valid dkim' do
      it { expect(record.dkim_valid?).to be true }
    end

    describe 'has a valid sfp' do
      it { expect(record.spf_valid?).to be true }
    end

    describe 'is fully valid' do
      it { expect(record.fully_valid?).to be true }
    end

    describe 'is partially valid' do
      it { expect(record.partially_valid?).to be true }
    end
  end
end
