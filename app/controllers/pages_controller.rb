class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  @budgets = Budget.all

  end

  private

    def getDebtStatus
      persons = []
      UserBudget.where(budget_id: budget.id).each do |n|
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

end
