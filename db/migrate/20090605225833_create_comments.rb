class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
    t.column :date, :timestamp
    t.column :subject, :string
    t.column :message, :string
    t.column :user_id, :int
    t.column :extension_id, :int
    t.column :parent_id, :int
    t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
