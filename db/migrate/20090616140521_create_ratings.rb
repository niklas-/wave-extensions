class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
    t.column :value, :int
    t.column :ip, :string
    t.column :extension_id, :int
    t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end

