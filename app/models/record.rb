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
    if auth_results['dkim'].instance_of?(Hash)
      {
        result: auth_results.dig('dkim', 'result'),
        selector: auth_results.dig('dkim', 'selector'),
        domain: auth_results.dig('dkim', 'domain')
      }
    elsif auth_results['dkim'].instance_of?(Array)
      {
        result: auth_results['dkim'].first['result'],
        selector: auth_results['dkim'].first['selector'],
        domain: auth_results['dkim'].first['domain']
      }
    end
  end

  def dkim_alignment
    (identifiers['header_from'] || feedback.policy_published['domain']) == dkim_authentication[:domain]
  end

  def dkim_result
    policy_evaluated['dkim']
  end

  def spf_authentication
    {
      result: auth_results.dig('spf', 'result'),
      domain: auth_results.dig('spf', 'domain')
    }
  end

  def spf_alignment
    (identifiers['header_from'] || feedback.policy_published['domain']) == spf_authentication[:domain]
  end

  def spf_result
    policy_evaluated['spf']
  end

  def dkim_pass
    if feedback.policy_published['adkim'] && feedback.policy_published['adkim'] == 's'
      dkim_result == 'pass' && dkim_alignment
    else
      dkim_result == 'pass'
    end
  end

  def spf_pass
    if feedback.policy_published['aspf'] && feedback.policy_published['aspf'] == 's'
      spf_result == 'pass' && spf_alignment
    else
      spf_result == 'pass'
    end
  end

  def dmarc
    dkim_pass || spf_pass
  end
end
