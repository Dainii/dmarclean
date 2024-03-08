# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.1.3'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Really simple JSON and XML parsing, ripped from Merb and Rails.
gem 'crack'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Database-backed Active Job backend.
gem 'solid_queue'

# Autoload dotenv in Rails
gem 'dotenv-rails'

# rubyzip is a ruby module for reading and writing zip files
gem 'rubyzip'

# Ruby interface for the zlib compression/decompression library
gem 'zlib'

# Monitor your jobs
gem 'activejob-status'

# Interface for secure random number generator.
gem 'securerandom'

# Provides Rails integration for Rodauth.
gem 'omniauth-saml'
gem 'rodauth-i18n'
gem 'rodauth-omniauth'
gem 'rodauth-rails'
gem 'rotp'
gem 'rqrcode'
gem 'webauthn'

# Sentry
gem 'sentry-rails'
gem 'sentry-ruby'

# Dnsruby is a pure Ruby DNS client library which implements a stub resolver.
# It aims to comply with all DNS RFCs, including DNSSEC NSEC3 support.
gem 'dnsruby'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri windows]

  gem 'database_cleaner-active_record'

  # Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis
  gem 'brakeman', require: false

  gem 'bundler-audit', require: false

  gem 'erb_lint', require: false

  gem 'mission_control-jobs'

  # rspec-rails is a testing framework for Rails 5+
  gem 'rspec-rails'

  # RSpec results that your continuous integration service can read.
  gem 'rspec_junit_formatter'

  # RuboCop is a Ruby code style checking and code formatting tool.
  # It aims to enforce the community-driven Ruby Style Guide
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false

  gem 'shoulda-matchers'

  gem 'simplecov', require: false
  gem 'simplecov-cobertura', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # Ever wondered which translations are being looked up by Rails, a gem, or simply your app? Wonder no more!
  gem 'i18n-debug'

  gem 'htmlbeautifier'

  gem 'better_errors'
  gem 'binding_of_caller'
end
