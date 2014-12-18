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
  #pending "add some examples to (or delete) #{__FILE__}"

  before do
  end

  it "9:00-18:00の場合、#hours は 8.0 であること" do
    @vacation = Vacation.create(:id=>1, :user_id=>999, :start_datetime=>"2014/12/1 9:00:00", :end_datetime=>"2014/12/1 18:00:00", :memo=>"Test Data", :fixed=>true)
    expect(@vacation.hours).to eq 8.0
  end

  it "9:00-12:00の場合、#hours は 3.0 であること" do
    @vacation = Vacation.create(:id=>1, :user_id=>999, :start_datetime=>"2014/12/1 9:00:00", :end_datetime=>"2014/12/1 12:00:00", :memo=>"Test Data", :fixed=>true)
    expect(@vacation.hours).to eq 3.0
  end

  it "9:00-13:00の場合、#hours は 3.0 であること" do
    @vacation = Vacation.create(:id=>1, :user_id=>999, :start_datetime=>"2014/12/1 9:00:00", :end_datetime=>"2014/12/1 13:00:00", :memo=>"Test Data", :fixed=>true)
    expect(@vacation.hours).to eq 3.0
  end

  it "12:00-18:00の場合、#hours は 5.0 であること" do
    @vacation = Vacation.create(:id=>1, :user_id=>999, :start_datetime=>"2014/12/1 12:00:00", :end_datetime=>"2014/12/1 18:00:00", :memo=>"Test Data", :fixed=>true)
    expect(@vacation.hours).to eq 5.0
  end

  it "13:00-18:00の場合、#hours は 5.0 であること" do
    @vacation = Vacation.create(:id=>1, :user_id=>999, :start_datetime=>"2014/12/1 13:00:00", :end_datetime=>"2014/12/1 18:00:00", :memo=>"Test Data", :fixed=>true)
    expect(@vacation.hours).to eq 5.0
  end

end
