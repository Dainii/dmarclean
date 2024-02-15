# frozen_string_literal: true

class Domain < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  validates :name, presence: true

  def records_sum
    feedbacks.sum { |feedback| feedback.records.count }
  end
end
