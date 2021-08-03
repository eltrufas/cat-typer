class AddStatsToUser < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.float :wpm
      t.float :accuracy
    end
  end
end
