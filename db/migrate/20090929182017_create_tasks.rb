class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :days_to_complete
      t.integer :project_id
      t.integer :requester_user_id
      t.integer :performer_user_id
      t.integer :num_shares

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
