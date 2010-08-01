class AddTaskIdToExpandSharePoolDecisions < ActiveRecord::Migration
  def self.up
    add_column :expand_share_pool_decisions, :task_id, :integer
  end

  def self.down
    remove_column :expand_share_pool_decisions, :task_id
  end
end
