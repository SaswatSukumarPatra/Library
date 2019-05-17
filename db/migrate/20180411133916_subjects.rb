class Subjects < ActiveRecord::Migration[5.0]
  def change
    change_table :subjects do |t|
        t.column :name, :string
    end

    Subject.create :name => "Physics"
    Subject.create :name => "Mathematics"
    Subject.create :name => "Chemistry"
    Subject.create :name => "Psychology"
    Subject.create :name => "Geography"
  end
end
