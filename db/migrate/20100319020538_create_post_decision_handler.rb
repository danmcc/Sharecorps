class CreatePostDecisionHandler < ActiveRecord::Migration
  def self.up
    create_table :post_decision_handlers do |t|
      t.integer :decision_id
      t.text :expression

      t.timestamps
    end
  end

  def self.down
	drop_table :post_decision_handler
  end
end
