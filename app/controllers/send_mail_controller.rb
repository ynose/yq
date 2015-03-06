class SendMailController < ApplicationController
  MAIL_TO = "ynose.249@gmail.com"   # 送信先メールアドレス

  def new
  	vacation = Vacation.find(params[:id])
    user = User.find(vacation.user_id)

    @startdate = Date::new(vacation.start_datetime.year, vacation.start_datetime.month, vacation.start_datetime.day)

    @callback_url = params[:callback_url]

    @to = MAIL_TO
    @from = user.email
    @bcc = user.email
    @subject = "#{user.name} - 有休 [#{@startdate.strftime("%m").to_s}月#{@startdate.strftime("%d").to_s}日]"
    @body = "#{@startdate.strftime("%m").to_s} 月 #{@startdate.strftime("%d").to_s} 日"
  end

  def deliver
    vacation = Vacation.find(params[:id])
    user = User.find(vacation.user_id)

    @result = SendMail.send_to_report(user.email, MAIL_TO, user.email, deliver_params[:subject], deliver_params[:body]).deliver
  end

  private
    def deliver_params
      params.permit(:subject, :body)
    end

end
