class Books < ActiveRecord::Migration[5.0]
  # Change is automatically reversible
  # incase the automatic reversal is not preferred we use up and down explicitly
  # to define changes and rollback process
  def change
    change_table :books do |t|
        # reversible do |direction|
        #     direction.up{
        #         t.where(title: nil).update_all(title: "")
        #     }
        # end

        t.column :title , :string, :limit => 32, :null => false, :default => ""
        t.column :price, :float
        t.column :subject_id, :integer
        t.column :description, :text
    end
  end
end
