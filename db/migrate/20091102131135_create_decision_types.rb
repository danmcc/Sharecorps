class CreateDecisionTypes < ActiveRecord::Migration
  def self.up
    create_table :decision_types do |t|
      t.string :description
      t.timestamps
    end
  end

  def self.down
    drop_table :decision_types
  end
end
