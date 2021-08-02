class AddSlugToDictionary < ActiveRecord::Migration[6.1]
  def change
    add_column :dictionaries, :slug, :string
    add_index :dictionaries, :slug, unique: true
  end
end
