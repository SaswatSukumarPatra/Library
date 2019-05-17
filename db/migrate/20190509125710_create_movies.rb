class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :seats, array: true, default: []
      t.references :theater, foreign_key: true

      t.timestamps
    end
  end
end
