class CreateShareholders < ActiveRecord::Migration
  def self.up
    create_table :shareholders do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :num_shares

      t.timestamps
    end
  end

  def self.down
    drop_table :shareholders
  end
end
