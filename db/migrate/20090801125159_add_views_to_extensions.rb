class AddViewsToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :view_count, :int
  end

  def self.down
     remove_column :extensions, :view_count
  end
end
