class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :user_budgets, class_name: 'UserBudget'
  has_many :budgets, through: :user_budgets

  has_many :user_payments, class_name: 'UserPayment'
  has_many :payments, through: :user_payments

end
