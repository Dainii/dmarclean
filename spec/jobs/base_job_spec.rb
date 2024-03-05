# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseJob do
  ActiveJob::Base.queue_adapter = :test

  pending 'add some test for BaseJob'

  # FIXME
  # Sometime, it does not work
  # it { expect { described_class.perform_later }.to have_enqueued_job(described_class) }
end
