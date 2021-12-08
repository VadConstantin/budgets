class AddDefaultValueToDetteInUserBudgetsTable < ActiveRecord::Migration[6.0]
  def change
    change_column :user_budgets, :dette, :integer, default: 0
  end
end
