class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      # rails will autogenerate ids and this will lead to pkey violations
      # therefore :id => false
      t.column :role_id, :int
      t.column :user_id, :int
    end
  end
  
  def self.down
    drop_table :roles_users
  end
end