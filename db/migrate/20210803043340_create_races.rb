class CreateRaces < ActiveRecord::Migration[6.1]
  def change
    create_table :races do |t|
      t.belongs_to :user
      t.belongs_to :challenge
      t.integer :time
      t.integer :mistakes 

      t.timestamps
    end
  end
end
