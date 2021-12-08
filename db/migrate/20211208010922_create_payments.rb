class CreatePayments < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.integer :montant_cents
      t.string :commentaire
      t.references :budget, null: false, foreign_key: true
      t.timestamps
    end
  end
end
