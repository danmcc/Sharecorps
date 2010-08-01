class CreateTextChangeDecisions < ActiveRecord::Migration
  def self.up
    create_table :text_change_decisions do |t|
      t.string :target_field
      t.text :target_value

      t.timestamps
    end
  end

  def self.down
    drop_table :text_change_decisions
  end
end
