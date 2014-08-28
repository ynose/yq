class User < ActiveRecord::Base
  has_many :paid_vacations
  has_many :vacations
end
