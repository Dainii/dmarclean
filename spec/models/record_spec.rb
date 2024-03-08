# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Record do
  describe 'associations' do
    it { is_expected.to belong_to(:feedback) }
  end

  policy_published = {
    'adkim' => 'r',
    'aspf' => 'r',
    'p' => 'none',
    'sp' => 'none',
    'pct' => '100',
    'np' => 'none'
  }

  record_hash = {
    'row' => {
      'source_ip' => '240.1.2.3',
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

  record = described_class.new(feedback: Feedback.create!(policy_published:))

  context 'with extracted hash, it' do
    record.update_from_hash(record_hash)

    describe 'has a source_ip' do
      it { expect(record.source_ip).to eq('240.1.2.3') }
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
      it { expect(record.dkim_pass).to be true }
    end

    describe 'has a valid sfp' do
      it { expect(record.spf_pass).to be true }
    end

    describe 'is as DMARC valid' do
      it { expect(record.dmarc).to be true }
    end
  end
end
