# frozen_string_literal: true

RSpec.configure do |config|
  config.include Rodauth::Rails::Test::Controller, type: :controller
end
