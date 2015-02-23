class SendMail < ActionMailer::Base
  #default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_mail.sample_mail.subject
  #
  # 本文はapp/views/send_mail/sample_mail.text.erbにテンプレートを作成する
  def sample_mail(vacation_id)
    vacation = Vacation.find(vacation_id)
    user = User.find(vacation.user_id)

    @startdate = Date::new(vacation.start_datetime.year, vacation.start_datetime.month, vacation.start_datetime.day)

    mail from: "#{user.email}", to: "ynose.249@gmail.com", subject: "#{user.name} - 有休 [#{@startdate.strftime("%m").to_s}月#{@startdate.strftime("%d").to_s}日]"
  end
end
