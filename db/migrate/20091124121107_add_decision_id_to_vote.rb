class AddDecisionIdToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :decision_id, :integer
  end

  def self.down
    remove_column :votes, :decision_id
  end
end
