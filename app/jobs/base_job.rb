# frozen_string_literal: true

class BaseJob < ApplicationJob
  include ActiveJob::Status

  queue_as :default
end
