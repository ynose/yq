class User < ActiveRecord::Base
end

#Create New Data
#u = User.create(:id => 999, :name => "example", :email => "yuq@example.com")


# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
