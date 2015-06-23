class PaidVacation < ActiveRecord::Base
  belongs_to :user
end

# 本番環境へのデータ登録方法
# $ heroku run console
# 新規追加
# irb> p = PaidVacation.create(:user_id=>131, :year=>2015, :hours=>160, :carryover_hours=>155)

# 更新
# irb> PaidVacation.where(user_id: 131)
# irb> p = PaidVacation.find(4)
# irb> p.hours = 160
# irb> p.carryover_hours = 155
# irb> p.save

# irb> exit


# == Schema Information
#
# Table name: paid_vacations
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  year            :integer
#  hours           :float
#  carryover_hours :float
#  created_at      :datetime
#  updated_at      :datetime
#
