# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'dotenv-rails', groups: %i[development test]

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
gem 'rack-cors'

gem 'devise', '~> 4.3'

gem 'active_model_serializers', '~> 0.10.6'

gem 'httparty', '~> 0.15.6'

gem 'pusher'

group :development, :test do
  gem 'faker'
end

group :test do
  gem 'codeclimate-test-reporter', '~> 1.0', '>= 1.0.8'
  gem 'database_cleaner', '~> 1.6', '>= 1.6.2'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'rspec-rails', '~> 3.7', '>= 3.7.1'
  gem 'simplecov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'sentry-raven'
end
