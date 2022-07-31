class Budget < ApplicationRecord
  has_many :user_budgets, class_name: 'UserBudget', dependent: :destroy
  has_many :users, through: :user_budgets

  has_many :payments, dependent: :destroy

  validates :name, presence: true


  def get_debt_status
    persons = []
    UserBudget.where(budget_id: self.id).each do |n|
        persons << {name: n.user.name, dette: n.dette}
    end
    if persons[1].nil? == false
      if persons[0][:dette] > persons[1][:dette]
        return "#{persons[1][:name]} owes #{(persons[0][:dette]) - (persons[1][:dette])} € to #{persons[0][:name]}"
      elsif persons[0][:dette] < persons[1][:dette]
        return "#{persons[0][:name]} owes #{(persons[1][:dette]) - (persons[0][:dette])} € to #{persons[1][:name]}"
      else
        return "Nothing to pay"
      end
    end
  end

  def get_participants

  end

end
