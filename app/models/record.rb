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

  def dkim_valid?
    auth_results.dig('dkim', 'result') == 'pass'
  end

  def spf_valid?
    auth_results.dig('spf', 'result') == 'pass'
  end

  def fully_valid?
    dkim_valid? && spf_valid?
  end

  def partially_valid?
    dkim_valid? || spf_valid?
  end
end
