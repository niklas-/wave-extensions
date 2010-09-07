class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.column :name, :string
      t.column :parent_id, :int
      t.timestamps
    end
    
    root = Category.create :name => "root"
    Category.create :name => "Robots", :parent => root
    Category.create :name => "Gadget", :parent => root

  end
  
  def self.down
    drop_table :categories
  end
end
