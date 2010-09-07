class AddCategoryToExtension < ActiveRecord::Migration
  def self.up
    add_column :extensions, :category_id, :int
  end
  
  def self.down
    remove_column :extensions, :category_id
  end
end
