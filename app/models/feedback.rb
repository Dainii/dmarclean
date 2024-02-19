# frozen_string_literal: true

require 'zip'

class Feedback < ApplicationRecord
  before_create :add_random_report_id

  belongs_to :domain, optional: true
  belongs_to :organization, optional: true
  has_many :records, dependent: :destroy

  has_one_attached :report

  validates :report_id, uniqueness: { scope: :domain }

  def extract_report
    case report.filename.to_s
    when /.zip$/
      extract_from_zip_archive
    when /.xml$/
      extract_from_xml
    when /.gz$/
      extract_from_gzip_archive
    end
  end

  def extract_data
    extract_report_id
    extract_dates
    extract_organization
    extract_domain
    extract_policy_published
    extract_records

    return if Feedback.exists?(report_id:, domain:)

    save
  end

  def fully_valid?
    records.all?(&:fully_valid?)
  end

  def partially_valid?
    records.any?(&:fully_valid?)
  end

  def dkim_fully_valid?
    records.all?(&:dkim_valid?)
  end

  def dkim_partially_valid?
    records.any?(&:dkim_valid?)
  end

  def spf_fully_valid?
    records.all?(&:spf_valid?)
  end

  def spf_partially_valid?
    records.any?(&:spf_valid?)
  end

  private

  def add_random_report_id
    self.report_id = SecureRandom.alphanumeric(30) if report_id.nil?
  end

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

  def extract_from_zip_archive
    Zip::File.open_buffer(report.download) do |zip|
      zip.each do |entry|
        next unless entry.name.match?(/.xml$/)

        self.raw_content = JSON.parse(Crack::XML.parse(entry.get_input_stream.read).to_json)
        save

        return true
      end
    end
  end

  def extract_from_gzip_archive
    report.open do |r|
      gz_file = Zlib::GzipReader.new(r)

      self.raw_content = JSON.parse(Crack::XML.parse(gz_file.read).to_json)
      save
    end
  end

  def extract_from_xml
    self.raw_content = JSON.parse(Crack::XML.parse(report.download).to_json)

    save
  end
end
