class CreateExtensions < ActiveRecord::Migration
  def self.up
    create_table :extensions do |t|
    t.column :name, :string
    t.column :url, :string
    t.column :description, :text
    t.column :numdownloads, :integer
    t.timestamps
    end
  end

  def self.down
    drop_table :extensions
  end
end
