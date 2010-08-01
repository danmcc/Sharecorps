class AddTaskIdToWhoShouldDoSomethingDecisions < ActiveRecord::Migration
  def self.up
	  add_column :who_should_do_something_decisions, :task_id, :integer
  end

  def self.down
  end
end
