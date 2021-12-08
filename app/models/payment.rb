class Payment < ApplicationRecord

  validates :commentaire, presence: true
  validates :montant_cents, presence: true

  belongs_to :budget
  has_many :user_payments, dependent: :destroy
  has_many :users, through: :user_payments
end
