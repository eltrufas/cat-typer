class AddDescriptionToPrompt < ActiveRecord::Migration[6.1]
  def change
    change_table :prompts do |t|
      t.text :description, null: false, default: ""
    end
  end
end
