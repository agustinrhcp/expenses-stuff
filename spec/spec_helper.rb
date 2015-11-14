ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/factories/*.rb')].each { |f| require f }
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec

  config.infer_spec_type_from_file_location!

  config.use_transactional_fixtures = true
end

def login_user(user = nil)
  FactoryGirl.create(:user).tap { |user| session[:user_id] = user.id }
end
