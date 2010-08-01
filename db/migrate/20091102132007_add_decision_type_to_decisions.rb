class AddDecisionTypeToDecisions < ActiveRecord::Migration
  def self.up
    add_column :decisions, :decision_type_id, :integer
  end

  def self.down
    remove_column :decisions, :decision_type_id
  end
end
