class DropPrimaryKeyInJoinTables < ActiveRecord::Migration
  def self.up
  	  remove_column :decisions_tasks, :id
  	  remove_column :user_collections_users, :id
  end

  def self.down
  end
end
