# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'うつメイト <noreply@utsumate.net>'
  layout 'mailer'
end
