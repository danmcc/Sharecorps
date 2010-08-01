class AddDecisionDetailIdDropSummaryDescriptionToDecisions < ActiveRecord::Migration
  def self.up
    add_column :decisions, :decision_detail_id, :integer
    remove_column :decisions, :summary
    remove_column :decisions, :description
  end

  def self.down
    remove_column :decisions, :decision_detail_id
  end
end
