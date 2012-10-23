require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  unless ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails' do
      add_filter '/extras/'
    end
  end
  
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  include Capybara::DSL
  
  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
  end
  
end

Spork.each_run do

  if ENV['DRB']
    require 'simplecov'
    SimpleCov.start 'rails'
  end
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
end



