class CreateUserFriends < ActiveRecord::Migration[5.2]
  def change
    create_table :user_friends do |t|
      t.references :user, foreign_key: true
      t.references :friend
      t.timestamps
    end
  end
end
