# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = false
Rails.application.initialize!
