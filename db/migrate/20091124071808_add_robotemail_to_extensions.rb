class AddRobotemailToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :robotmail, :string
  end
  
  def self.down
    remove_column :extensions, :robotmail
  end
end
