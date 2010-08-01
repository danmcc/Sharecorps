class CreateExpandSharePoolDecision < ActiveRecord::Migration
  def self.up
    create_table :expand_share_pool_decisions do |t|
      t.timestamps
    end
  end

  def self.down
  end
end
