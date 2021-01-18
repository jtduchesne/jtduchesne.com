class ApplicationMailer < ActionMailer::Base
  default from: -> { "jtduchesne.com <#{t('do_not_reply', scope: :email)}@jtduchesne.com>" }
  layout 'mailer'
end
