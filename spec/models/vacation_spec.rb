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

require 'rails_helper'

RSpec.describe Vacation, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
