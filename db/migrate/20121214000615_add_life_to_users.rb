class AddLifeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :life, :integer, :default => 0
  end
end
