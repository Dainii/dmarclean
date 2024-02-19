# frozen_string_literal: true

class Record < ApplicationRecord
  belongs_to :feedback

  def update_from_hash(raw_record)
    self.source_ip = raw_record.dig('row', 'source_ip')
    self.count = raw_record.dig('row', 'count').to_i
    self.policy_evaluated = raw_record.dig('row', 'policy_evaluated')
    self.identifiers = raw_record['identifiers']
    self.auth_results = raw_record['auth_results']

    save
  end

  def dkim_authentication
    return auth_results.dig('dkim', 'result') if auth_results['dkim'].instance_of?(Hash)

    return auth_results['dkim'].find { |auth| auth['domain'] == feedback.domain.name }['result'] if auth_results['dkim']

    'none'
  end

  def dkim_alignment
    policy_evaluated['dkim']
  end

  def dkim_valid?
    dkim_alignment == 'pass'
  end

  def spf_authentication
    auth_results.dig('spf', 'result')
  end

  def spf_alignment
    policy_evaluated['spf']
  end

  def spf_valid?
    spf_alignment == 'pass'
  end

  def fully_valid?
    dkim_valid? && spf_valid?
  end

  def partially_valid?
    dkim_valid? || spf_valid?
  end
end
