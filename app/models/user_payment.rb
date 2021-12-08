class UserPayment < ApplicationRecord
  belongs_to :payment
  belongs_to :user
end
