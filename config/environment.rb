# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
ActionMailer::Base.smtp_settings[:enable_starttls_auto] = true
Rails.application.initialize!
