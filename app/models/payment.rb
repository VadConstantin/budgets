class Payment < ApplicationRecord

  validates :commentaire, presence: true
  validates :montant_cents, presence: true

  belongs_to :budget
  has_many :user_payments, dependent: :destroy
  has_many :users, through: :user_payments

  def receiver_name(arg)
    user_payments = self.user_payments
    if user_payments.length < 3         # 1 seul receveur dans ce cas
      receveurs = user_payments.select { |u| u.state == "receveur"}[0].user_id      # renvoie un ID
    else
      receveurs = user_payments.select { |u| u.state == "receveur"}.map { |user_payment| user_payment.user_id}   # renvoie un array d'IDs
    end
    return receveurs.is_a?(Integer) ? (receveurs == arg.id ? "You" : User.find(receveurs).name) : "#{User.find(receveurs.select { |u| u != arg.id})[0].name} and you"
  end


  def sender_name(arg)
    user_payments = self.user_payments
    sender = user_payments.select { |u| u.state == "payeur"}[0].user_id
    return sender == arg.id ? "You" : User.find(sender).name
  end

end
