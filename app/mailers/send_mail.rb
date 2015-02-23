class SendMail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_mail.sample_mail.subject
  #
  # 本文はapp/views/send_mail/sample_mail.text.erbにテンプレートを作成する
  def sample_mail
    @greeting = "Hi"

    mail to: "ynose.249@gmail.com", subject: "SendGrid Test"
  end
end
