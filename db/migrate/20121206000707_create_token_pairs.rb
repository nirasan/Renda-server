class CreateTokenPairs < ActiveRecord::Migration
  def change
    create_table :token_pairs do |t|
      t.string :access_token
      t.integer :expires_in
      t.integer :issued_at
      t.string :refresh_token
      t.integer :user_id

      t.timestamps
    end
  end
end
