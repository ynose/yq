# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# SendGrid
ActionMailer::Base.smtp_settings = {
  :user_name => "sgppn5fg@kke.com",
  :password => "chappy7263",
  :domain => "example.com",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
ActionMailer::Base.delivery_method = :smtp