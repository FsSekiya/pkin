source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.5'
gem 'autoprefixer-rails'
gem 'webpacker'
gem 'dotenv-rails'

gem 'simple_form'

# トークンベースの認証を行うためのgem
gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'devise-bootstrap-views'

# クロスドメイン対策のgem
gem 'rack-cors'
gem 'email_validator'

group :development, :test do
  gem 'better_errors'
  gem 'foreman'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'byebug', platform: :mri
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rubocop'
  gem 'selenium-webdriver'
  gem 'forgery_ja'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
