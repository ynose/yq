class User < ActiveRecord::Base
end

#データ作成
#user = User.new(:id => 131, :name => "ynose", :email => "yuq@example.com")
#user.save

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
