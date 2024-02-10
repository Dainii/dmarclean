# frozen_string_literal: true

class Domain < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  validates :name, presence: true
end
