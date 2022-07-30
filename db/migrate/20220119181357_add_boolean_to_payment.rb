class AddBooleanToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :bitcoin, :boolean
  end
end
