class DropDescriptionFromDecisions < ActiveRecord::Migration
  def self.up
  	  remove_column :decisions, :description
  	  remove_column :general_yes_no_decisions, :summary
  end

  def self.down
  end
end
