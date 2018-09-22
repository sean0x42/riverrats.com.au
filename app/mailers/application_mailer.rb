# frozen_string_literal: true

# Default settings for the application's mailers
class ApplicationMailer < ActionMailer::Base
  default from: 'riverratspl@gmail.com'
  layout 'mailer'
end
