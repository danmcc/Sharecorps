class CreateMultipleChoiceOptions < ActiveRecord::Migration
  def self.up
    create_table :multiple_choice_options do |t|
      t.integer :general_multiple_choice_decision_id
      t.string :option

      t.timestamps
    end
  end

  def self.down
    drop_table :multiple_choice_options
  end
end
