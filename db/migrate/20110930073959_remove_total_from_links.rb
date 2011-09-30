class RemoveTotalFromLinks < ActiveRecord::Migration
  def self.up
    remove_column :links, :total
  end

  def self.down
    add_column :links, :total, :integer
  end
end
