# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

config.after_initialize do
  Delayed::Job.scaler = :heroku_cedar
end
