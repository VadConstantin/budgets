class AddDetteToUserBudgets < ActiveRecord::Migration[6.0]
  def change
    add_column :user_budgets, :dette, :integer
  end
end
