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

require 'rails_helper'

RSpec.describe PaidVacation, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
end
