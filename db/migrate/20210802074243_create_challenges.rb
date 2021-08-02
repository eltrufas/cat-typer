class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|
      t.text :text
      t.boolean :generated, null: false, default: false
      t.boolean :used, null: false, default: false
      t.belongs_to :prompt

      t.timestamps
    end
  end
end
