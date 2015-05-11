class AddPasswordAndTokenToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :password_digest, :string
    add_column :agents, :token, :string
  end
end
