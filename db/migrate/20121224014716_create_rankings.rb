class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.string :category
      t.integer :user_id
      t.integer :count

      t.timestamps
    end
  end
end
