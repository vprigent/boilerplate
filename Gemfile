source 'https://rubygems.org'
ruby '2.6.5'

gem 'rails', '~> 5.0.0'
gem 'spring',        group: :development
gem 'puma'
gem 'settingslogic'
gem 'sendgrid' # marked for deletion
gem 'sdoc', '~> 0.4.0',          group: :doc # marked for deletion

# Auth
gem 'devise'
gem 'devise-i18n'
gem 'devise_masquerade'
gem 'pundit'

# Database
gem 'pg'

# Views
gem 'haml-rails'
gem 'simple_form'
gem 'nested_form'
gem 'enum_help'
gem 'redcarpet'

# Assets
gem 'sassc-rails'
gem 'uglifier'#, '>= 1.3.0'
gem 'coffee-rails'#, '~> 4.0.0'
gem 'jquery-rails' # marked for hopeful deletion
gem 'jbuilder'#, '~> 2.0'
gem 'bootstrap-sass'
gem 'bourbon'
gem 'eco' # marked for deletion

# Models
gem 'kaminari' # to replace with pagy for faster collection management
gem 'verbs'

# Uploaders
gem 'mini_magick', require: false
gem 'carrierwave'
gem 'carrierwave-aws'
gem 'faker'

# Delayed Job
gem 'delayed_job'
gem 'delayed_job_active_record'

# Notifier
gem 'exception_notification'

# Sumo custom tools
gem 'tprint-debug', git: 'https://github.com/3print/tprint-debug'
gem 'sumo_seed', git: 'https://github.com/3print/sumo_seed'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_22, :mri_23, :rbx] # replace with pry
  gem 'html2haml'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false # for windows
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  # Guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-spork'#, '1.5.1'
  gem 'guard-livereload'#, '1.0.3'

  gem 'rspec'#, '>=3.0'

  gem 'listen'#, '1.3.0'
  gem 'spork'#, '1.0.0rc3'

  gem 'annotate'
end

group :development, :test do
  gem 'factory_girl_rails' # replace with factory_bot_rails
  gem 'pry-rails' # marked for deletion, adding pry will be enough
  gem 'pry-rescue'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara' # marked for deletion
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'launchy' # marked for deletion
  gem 'selenium-webdriver' # marked for deletion
end

Dir["./*-gemfile.rb"].each do |f|
  eval File.read(f), nil, f
end
