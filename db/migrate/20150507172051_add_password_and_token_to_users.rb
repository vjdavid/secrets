class AddPasswordAndTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string
    add_column :users, :token, :string
  end
end
