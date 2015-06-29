class DashboardController < ApplicationController

  layout 'onsen'

  def index

  end

  # def show
  #   user_id = params[:user_id]
  #   year = params[:year]            # 年度のはじめ月(４月)
  #   year_end = (year.to_i + 1).to_s # 年度のおわり月(３月)

  #   @user = User.find(user_id)
  #   @paid_vacation = PaidVacation.find_by(user_id: user_id, year: year)
  #   #指定のユーザーIDと年度が見つからない場合は、とりあえず支給０で作成する
  #   unless @paid_vacation then
  #     PaidVacation.create(:user_id=>user_id, :year=>year, :hours=>0, :carryover_hours=>0)
  #     @paid_vacation = PaidVacation.find_by(user_id: user_id, year: year)
  #   end

  #   #指定年度の休暇リストを取得(指定年度(4月1日〜3月31日)の範囲を検索)
  #   @vacations = Vacation.where(["user_id = ? and ? <= start_datetime and end_datetime <= ?",
  #                               user_id,
  #                               year + '-04-01 00:00:00',
  #                               year_end + '-03-31 23:59:59'])
  #                               .order("start_datetime desc")

  #   @vacation_hours_total = 0
  #   @vacationHourOfMonth = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  #   @vacations.each do |vacation|
  #     # 年間の有休消化時間を集計する
  #     @vacation_hours_total += vacation.hours

  #     # 月ごとの有休消化時間を集計する
  #     @vacationHourOfMonth[vacation.start_datetime.strftime("%m").to_i] += vacation.hours
  #   end

  #   render :action  => 'onsen'
  # end
  def show
    user_id = params[:user_id]
    year = params[:year]            # 年度のはじめ月(４月)

    @user = User.find(user_id)
    @year = year

    paid_vacation = PaidVacation.find_by(user_id: user_id, year: year)
    #指定のユーザーIDと年度が見つからない場合は、とりあえず支給０で作成する
    unless paid_vacation then
      PaidVacation.create(:user_id=>user_id, :year=>year, :hours=>0, :carryover_hours=>0)
    end

    render :action  => 'onsen'
  end


  def remain_ajax
    user_id = params[:user_id]
    year = params[:year]            # 年度のはじめ月(４月)
    year_end = (year.to_i + 1).to_s # 年度のおわり月(３月)

    paid_vacation = PaidVacation.find_by(user_id: user_id, year: year)
    #指定のユーザーIDと年度が見つからない場合は、とりあえず支給０で作成する
    unless paid_vacation then
      PaidVacation.create(:user_id=>user_id, :year=>year, :hours=>0, :carryover_hours=>0)
      paid_vacation = PaidVacation.find_by(user_id: user_id, year: year)
    end

    #指定年度の休暇リストを取得(指定年度(4月1日〜3月31日)の範囲を検索)
    vacations = Vacation.where(["user_id = ? and ? <= start_datetime and end_datetime <= ?",
                                user_id,
                                year + '-04-01 00:00:00',
                                year_end + '-03-31 23:59:59'])
                                .order("start_datetime desc")

    vacation_total_hours = 0
    vacationHours = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    vacations.each do |vacation|
      # 年間の有休消化時間を集計する
      vacation_total_hours += vacation.hours

      # 月ごとの有休消化時間を集計する
      vacationHours[vacation.start_datetime.strftime("%m").to_i] += vacation.hours
    end
    
    carryover_hours = paid_vacation.carryover_hours < vacation_total_hours ? paid_vacation.carryover_hours : vacation_total_hours
    carryover_hours_remain = vacation_total_hours < paid_vacation.carryover_hours ? paid_vacation.carryover_hours - vacation_total_hours : 0
    over_hours = paid_vacation.carryover_hours + paid_vacation.hours < vacation_total_hours ? vacation_total_hours - (paid_vacation.carryover_hours + paid_vacation.hours) : 0
    hours = vacation_total_hours - (carryover_hours + over_hours)

    paid_vacation_total_hours = paid_vacation.hours + paid_vacation.carryover_hours
    total_hours = (paid_vacation_total_hours + over_hours)

    # 残り日数と時間
    remain_days = ((paid_vacation_total_hours - vacation_total_hours) / 8).to_i
    remain_hours = ((paid_vacation_total_hours - vacation_total_hours) - (remain_days * 8)).to_i


    # 月ごとの消化時間を4月始まりの並びにする
    month = [4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3]   # この順序でViewに表示される
    vacationHourAtMonth = []
    month.each do |m|
      targetmonth = Date::new(paid_vacation.year + (4 <= m ? 0 : 1), m , 1)
      thismonth = Date::new(Date.today.year, Date.today.month, 1)
      vacationHourAtMonth.push(
        {
          'month' => m, 
          'hour' => vacationHours[m], 
          'term' => if targetmonth < thismonth then "past" else "" end
        })
    end

    # 結果をJSONで返す
    remain = {
      'paid_vacation_hours' => paid_vacation.hours,
      'paid_vacation_carryover_hours' => paid_vacation.carryover_hours,
      'carryover_hours' => carryover_hours,
      'carryover_hours_remain' => carryover_hours_remain,
      'vacation_total_hours' => vacation_total_hours,
      'over_hours' => over_hours,
      'hours' => hours,
      'paid_vacation_total_hours' => paid_vacation_total_hours,
      'total_hours' => total_hours,
      'remain_days' => remain_days,
      'remain_hours' => remain_hours,
      'vacationHourAtMonth' => vacationHourAtMonth,
      'vacationHour_max' => vacationHours.max
    }

    render :json => remain

  end

end
