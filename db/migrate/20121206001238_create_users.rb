class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :mail_address
      t.string :username

      t.timestamps
    end
  end
end
