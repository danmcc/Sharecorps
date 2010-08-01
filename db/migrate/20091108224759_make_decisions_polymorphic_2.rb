class MakeDecisionsPolymorphic2 < ActiveRecord::Migration
  def self.up
    drop_table :decisions

    create_table :decisions do |t|
      t.integer :project_id
      t.integer :creator_user_id
      t.string :summary
      t.text :description
      t.string :result
      t.date :expiration_date
  	  t.references :decidable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
  end
end
