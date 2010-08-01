class AddOfferedOrWantedToTasks < ActiveRecord::Migration
  def self.up
    add_column "tasks", "offered_or_wanted", :string
  end

  def self.down
    drop_column "tasks", "offered_or_wanted"
  end
end
