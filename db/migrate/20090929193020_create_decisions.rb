class CreateDecisions < ActiveRecord::Migration
  def self.up
    create_table :decisions do |t|
      t.integer :project_id
      t.integer :creator_user_id
      t.string :summary
      t.text :description
      t.string :result

      t.timestamps
    end
  end

  def self.down
    drop_table :decisions
  end
end
