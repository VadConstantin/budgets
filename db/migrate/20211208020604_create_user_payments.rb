class CreateUserPayments < ActiveRecord::Migration[6.0]
  def change
    create_table :user_payments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.string :state
      t.timestamps
    end
  end
end
