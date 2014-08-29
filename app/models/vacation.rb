class Vacation < ActiveRecord::Base
  belongs_to :user
  
  def hours
      # 有休消化時間を集計する
      seconds = 0
      seconds = seconds + (end_datetime - start_datetime)
      
      # 昼休み(12:00-13:00)をまたぐ場合は1hマイナスする
      seconds = seconds - (1 * 60 * 60) if start_datetime.hour <= 12 and
                                           13 <= end_datetime.hour
  
      return seconds / 60 / 60
  end
  
end
