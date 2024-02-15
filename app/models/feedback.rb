# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :domain, optional: true
  belongs_to :organization, optional: true
  has_many :records, dependent: :destroy

  has_one_attached :report

  def parse_xml_report
    # Parse the XML report and save it as json
    self.raw_content = JSON.parse(Crack::XML.parse(report.download).to_json)

    save
  end

  def extract_data
    extract_report_id
    extract_dates
    extract_organization
    extract_domain
    extract_policy_published
    extract_records

    save
  end

  def fully_valid?
    records.all?(&:fully_valid?)
  end

  def partially_valid?
    records.any?(&:fully_valid?)
  end

  private

  def extract_report_id
    self.report_id = raw_content['feedback']['report_metadata']['report_id']
  end

  def extract_dates
    self.begin_date = Time.at(raw_content['feedback']['report_metadata']['date_range']['begin'].to_i).utc
    self.end_date = Time.at(raw_content['feedback']['report_metadata']['date_range']['end'].to_i).utc
  end

  def extract_organization
    self.organization = Organization.find_or_create_by(
      name: raw_content['feedback']['report_metadata']['org_name']
    )
  end

  def extract_domain
    self.domain = Domain.find_or_create_by(
      name: raw_content['feedback']['policy_published']['domain']
    )
  end

  def extract_policy_published
    self.policy_published = raw_content['feedback']['policy_published'].except('domain')
  end

  def extract_records
    return if raw_content.dig('feedback', 'record').empty?

    if raw_content['feedback']['record'].instance_of?(Hash)
      record = records.new
      record.update_from_hash(raw_content['feedback']['record'])
    elsif raw_content['feedback']['record'].instance_of?(Array)
      raw_content['feedback']['record'].each do |raw_record|
        record = records.new
        record.update_from_hash(raw_record)
      end
    end
  end
end
