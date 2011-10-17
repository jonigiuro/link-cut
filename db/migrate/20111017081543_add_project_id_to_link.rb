class AddProjectIdToLink < ActiveRecord::Migration
  def self.up
    add_column :links, :project_id, :integer
  end

  def self.down
    remove_column :links, :project_id
  end
end
