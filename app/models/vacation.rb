class Vacation < ActiveRecord::Base
  belongs_to :user
  
  # 有休消化時間を集計する
  def hours
      seconds = 0
      seconds = seconds + (end_datetime - start_datetime)
      
      # 昼休み(12:00-13:00)をまたぐ場合は1hマイナスする
      seconds = seconds - (1 * 60 * 60) if start_datetime.hour <= 12 and
                                           13 <= end_datetime.hour
  
      return seconds / 60 / 60
  end

  # 年度を返す
  def year
      yyyy = start_datetime.year
      mm = start_datetime.month
      yyyy -= 1 if mm <= 3

      return yyyy
  end

  def yyyy
      return start_datetime.year
  end

  def mm
      return start_datetime.month
  end

  def dd
      return start_datetime.day
  end

  def weekday
      youbi = %w[日 月 火 水 木 金 土]
      return youbi[start_datetime.wday]
  end

end

# == Schema Information
#
# Table name: vacations
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  start_datetime :datetime
#  end_datetime   :datetime
#  memo           :text
#  fixed          :boolean
#  created_at     :datetime
#  updated_at     :datetime
#
