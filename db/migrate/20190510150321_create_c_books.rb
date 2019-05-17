class CreateCBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :c_books do |t|
      t.string :name
      t.string :author
      t.date :publish_year
      t.string :category
      t.float :price
      t.integer :sold_count

      t.timestamps
    end
  end
end
