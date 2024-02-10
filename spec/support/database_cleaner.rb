# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner[:active_record].strategy = :truncation
    DatabaseCleaner[:active_record].clean_with(:truncation)

    Rails.application.load_seed
  end
end
