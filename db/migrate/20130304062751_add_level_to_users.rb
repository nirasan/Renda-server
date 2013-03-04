class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :level, :integer, :default => 1
    add_column :users, :total_count, :integer, :default => 0
    add_column :users, :game_time, :integer, :default => 5
  end
end
