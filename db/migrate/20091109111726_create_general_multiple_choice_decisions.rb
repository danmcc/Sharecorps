class CreateGeneralMultipleChoiceDecisions < ActiveRecord::Migration
  def self.up
    create_table :general_multiple_choice_decisions do |t|
      t.string :question

      t.timestamps
    end
  end

  def self.down
    drop_table :general_multiple_choice_decisions
  end
end
