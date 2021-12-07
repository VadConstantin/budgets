class UserPayment < ApplicationRecord
  belongs_to :payments
  belongs_to :users
end
