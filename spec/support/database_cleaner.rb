# frozen_string_literal: true

require 'database_cleaner/active_record'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end
end
