class AddIndexToCBooks < ActiveRecord::Migration[5.0]
  disable_ddl_transaction!

  def change
    add_index :c_books, :name, algorithm: :concurrently
    add_index :c_books, :author, algorithm: :concurrently
    add_index :c_books, :category, algorithm: :concurrently
    add_index :c_books, :sold_count, algorithm: :concurrently
  end
end
