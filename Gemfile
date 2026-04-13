source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 8.1.3"
gem "vite_rails", "~> 3.10.0"
gem "rails-i18n", "~> 8.0"
gem "devise", "~> 5.0"
gem "aasm", "~> 5.3"
gem "importmap-rails", "~> 2.0"
gem "cancancan", "~> 3.6"
gem "paranoia", "~> 3.1.0"
gem "faker", "~> 3.6.1", require: false
gem "kaminari", "~> 1.2.2"

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 6.5"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Use database-backed adapters for Rails.cache and Active Job
gem "solid_cache", "~> 1.0"
gem "solid_queue", "~> 1.0"

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", "~> 2.0", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", "~> 0.1.20", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", "~> 8.0.4", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop", "~> 1.86", require: false
  gem "rubocop-rails-omakase", "~> 1.0", require: false

  gem "annotaterb", "~> 4.0"
  gem "foreman", "~> 0.88"
  gem "rspec-rails", "~> 8.0"
  gem "factory_bot_rails", "~> 6.5.1"
  gem "shoulda-matchers", "~> 7.0"
  gem "capybara", "~> 3.40"
  gem "selenium-webdriver", "~> 4.43"
end

gem "tailwindcss-rails", "~> 4.4"
gem "active_model_serializers", "~> 0.10.16"
