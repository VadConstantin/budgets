class Payment < ApplicationRecord
  belongs_to :budgets
  has_many :user_payments
  has_many :users, through: :user_payments
end
