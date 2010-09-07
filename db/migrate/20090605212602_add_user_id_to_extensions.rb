class AddUserIdToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :user_id, :integer
  end

  def self.down
    remove_column :extensions, :user_id
  end
end