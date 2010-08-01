class CreateDecisionGeneralYesNo < ActiveRecord::Migration
  def self.up
    create_table :decisions_general_yes_no do |t|
      t.string :summary
      t.text :description

      t.timestamps
    end
  end

  def self.down
  end
end
