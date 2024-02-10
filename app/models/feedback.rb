# frozen_string_literal: true

class Feedback < ApplicationRecord
  belongs_to :domain, optional: true
  belongs_to :organization, optional: true

  has_one_attached :report
end
