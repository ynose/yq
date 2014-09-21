class PaidVacation < ActiveRecord::Base
  belongs_to :user
end

#データ作成
# paid_vacation = PaidVacation.new(:user_id=>131, :year=>2014, :hours=>160, :carryover_hours=>160)
# paid_vacation.save