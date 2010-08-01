class CreateTaskShares < ActiveRecord::Migration
  def self.up
    create_table :task_shares do |t|
      t.integer :task_id
      t.integer :user_id
      t.integer :num_shares

      t.timestamps
    end
  end

  def self.down
    drop_table :task_shares
  end
end
