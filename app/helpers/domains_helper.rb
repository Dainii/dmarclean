# frozen_string_literal: true

module DomainsHelper
  def format_date(date)
    date.to_fs(:long)
  end
end
