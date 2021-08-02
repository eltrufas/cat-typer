class CreatePrompts < ActiveRecord::Migration[6.1]
  def change
    create_table :prompts do |t|
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
