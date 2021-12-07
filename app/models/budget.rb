class Budget < ApplicationRecord
  has_many :user_budgets, class_name: 'UserBudget', dependent: :destroy
  has_many :users, through: :user_budgets
end
