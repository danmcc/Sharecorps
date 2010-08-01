class RemoveIdFromDecisionsUserCollections < ActiveRecord::Migration
  def self.up
  	  remove_column :decisions_user_collections, :id
  end

  def self.down
  end
end
