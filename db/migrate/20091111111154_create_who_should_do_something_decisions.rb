class CreateWhoShouldDoSomethingDecisions < ActiveRecord::Migration
  def self.up
    create_table :who_should_do_something_decisions do |t|
      t.timestamps
    end
  end

  def self.down
    drop_table :who_should_do_something_decisions
  end
end
