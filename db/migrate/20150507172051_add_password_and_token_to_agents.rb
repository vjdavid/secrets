class AddPasswordAndTokenToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :password, :string
    add_column :agents, :token, :string
  end
end
