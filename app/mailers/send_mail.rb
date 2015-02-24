class SendMail < ActionMailer::Base
  #default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_mail.sample_mail.subject
  #
  # 本文はapp/views/send_mail/sample_mail.text.erbにテンプレートを作成する
  def send_to_report(from, to, subject, body)
    @body = body
    mail from: from, to: to, subject: subject
  end
end
