# frozen_string_literal: true

class FeedbackUpload < ApplicationRecord
  after_commit :generate_feedbacks, on: :create

  has_many_attached :archives

  private

  def generate_feedbacks
    GenerateFeedbacksJob.set(wait: 5.seconds).perform_later(self)
  end
end
