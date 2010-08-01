class AddTextIdToDecisionTypes < ActiveRecord::Migration
  def self.up
    add_column :decision_types, :text_id, :string
  end

  def self.down
    remove_column :decision_types, :text_id
  end
end
