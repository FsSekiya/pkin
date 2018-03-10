source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'active_model_serializers'
gem 'autoprefixer-rails'
gem 'dotenv-rails'
gem 'jbuilder', '~> 2.5'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'webpacker'

gem 'kaminari'
gem 'simple_form'

# トークンベースの認証を行うためのgem
gem 'devise'
gem 'devise-bootstrap-views', git: 'https://github.com/hisea/devise-bootstrap-views.git', branch: 'bootstrap4'
gem 'devise_token_auth'
gem 'omniauth'

# クロスドメイン対策のgem
gem 'email_validator'
gem 'rack-cors'

gem 'faker'
gem 'forgery_ja'

# 監視・監査
gem 'paper_trail'

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'byebug', platform: :mri
  gem 'foreman'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rails-erd'
  gem 'rubocop'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
