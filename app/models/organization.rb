# frozen_string_literal: true

class Organization < ApplicationRecord
  has_many :feedbacks, dependent: :nullify

  validates :name, presence: true
end
