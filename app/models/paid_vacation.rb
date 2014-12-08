class PaidVacation < ActiveRecord::Base
  belongs_to :user
end

#データ作成
# paid_vacation = PaidVacation.new(:user_id=>131, :year=>2014, :hours=>160, :carryover_hours=>160)
# paid_vacation.save

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
