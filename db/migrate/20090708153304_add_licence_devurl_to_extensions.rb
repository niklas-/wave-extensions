class AddLicenceDevurlToExtensions < ActiveRecord::Migration
  def self.up
    add_column :extensions, :developerurl, :string
    add_column :extensions, :license, :string
  end

  def self.down
    remove_column :extensions, :developerurl
    remove_column :extensions, :license
  end
end
