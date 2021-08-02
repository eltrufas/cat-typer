class CreateDictionaryWords < ActiveRecord::Migration[6.1]
  def change
    create_table :dictionary_words do |t|
      t.text :text, null: false

      t.timestamps
    end
  end
end
