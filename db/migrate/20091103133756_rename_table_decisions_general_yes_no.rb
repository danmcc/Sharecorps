class RenameTableDecisionsGeneralYesNo < ActiveRecord::Migration
  def self.up
  	rename_table "decisions_general_yes_no", "general_yes_no_decisions"
  end

  def self.down
  end
end
