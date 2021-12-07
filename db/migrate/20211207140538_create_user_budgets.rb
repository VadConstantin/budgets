class CreateUserBudgets < ActiveRecord::Migration[6.0]
  def change
    create_table :user_budgets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
