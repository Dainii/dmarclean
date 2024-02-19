# frozen_string_literal: true

class Domain < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  validates :name, presence: true

  # TODO: store this value to avoid calculating it everytimes
  def records_sum
    feedbacks.sum { |feedback| feedback.records.count }
  end
end
