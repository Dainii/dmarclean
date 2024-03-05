# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseJob do
  ActiveJob::Base.queue_adapter = :test

  it { expect { described_class.perform_later }.to have_enqueued_job(described_class) }
end
