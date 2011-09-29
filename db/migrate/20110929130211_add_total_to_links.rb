class AddTotalToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :total, :integer, :default  => 0
  end

  def self.down
    remove_column :links, :total
  end
end
