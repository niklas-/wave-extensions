class CreateAdminTags < ActiveRecord::Migration
  def self.up
    create_table :admin_tags do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_tags
  end
end
