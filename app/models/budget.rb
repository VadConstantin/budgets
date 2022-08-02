class Budget < ApplicationRecord
  has_many :user_budgets, class_name: 'UserBudget', dependent: :destroy
  has_many :users, through: :user_budgets

  has_many :payments, dependent: :destroy
  validates :name, presence: true

  def debt_status(current_user)
    persons = []
    UserBudget.where(budget_id: self.id).each { |n| persons << { name: n.user.name, dette: n.dette } }
    if persons[1]
      if persons[0][:dette] > persons[1][:dette]
        return "#{persons[1][:name] == current_user.name ? "You owe" : "#{persons[1][:name]} owes"} #{(persons[0][:dette]) - (persons[1][:dette])}€ to #{persons[0][:name] == current_user.name ? "You" : persons[0][:name]}"
      elsif persons[0][:dette] < persons[1][:dette]
        return "#{persons[0][:name] == current_user.name ? "You owe" : "#{persons[0][:name]} owes"} #{(persons[1][:dette]) - (persons[0][:dette])}€ to #{persons[1][:name] == current_user.name ? "You" : persons[1][:name]}"
      else
        return "Nothing to pay"
      end
    end
  end

  def other_participant(current_user)
    participants = []
    self.user_budgets.each do |n|
      participants << n.user.name
    end
    return participants.filter { |user| user != current_user.name}
  end

  def contains_user?(u)
    ids = []
    self.users.each do |user|
      ids << user.id
    end

    return ids.include?(u.id)
  end

end
