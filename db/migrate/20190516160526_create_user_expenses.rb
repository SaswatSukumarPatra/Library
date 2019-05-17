class CreateUserExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :user_expenses do |t|
      t.float :amount
      t.float :settled
      t.boolean :complete
      t.integer :payer_id, foreign_key: true
      t.integer :payee_id, foreign_key: true
      t.references :expense, foreign_key: true

      t.timestamps
    end
  end
end
