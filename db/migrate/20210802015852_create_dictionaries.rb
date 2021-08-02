class CreateDictionaries < ActiveRecord::Migration[6.1]
  def change
    create_table :dictionaries do |t|
      t.text :name, null: false

      t.timestamps
    end

    add_reference :dictionary_words, :dictionary, foreign_key: true
  end
end
