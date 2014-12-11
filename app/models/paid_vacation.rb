class PaidVacation < ActiveRecord::Base
  belongs_to :user
end

#Create New Data
# p = PaidVacation.create(:user_id=>131, :year=>2014, :hours=>160, :carryover_hours=>160)


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
