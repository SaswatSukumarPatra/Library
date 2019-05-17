class AddIndexToEUser < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :e_users, :email, unique: true, algorithm: :concurrently
  end
end
