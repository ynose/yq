class DashboardController < ApplicationController

  def show
    user_id = params[:user_id]
    year = params[:year]
    
    @user = User.find_by(user_id: user_id)
    @paid_vacation = PaidVacation.find_by(user_id: user_id,
                                          year: year)

    #指定年度の休暇リストを取得                                          
    @vacations = Vacation.where(["user_id = ? and strftime('%Y', start_datetime) = ?", user_id, year]).order("start_datetime desc")
    
    seconds = 0
    @vacations.each do |vacation|
      seconds = seconds + (vacation.end_datetime - vacation.start_datetime)
      
      # 昼休み(12:00-13:00)をまたぐ場合は1hマイナスする
      seconds = seconds - (1 * 60 * 60) if vacation.start_datetime.hour <= 12 and 13 <= vacation.end_datetime.hour
    end
    
    @hours = seconds / 60 / 60
  end

end
