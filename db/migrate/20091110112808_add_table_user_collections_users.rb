class AddTableUserCollectionsUsers < ActiveRecord::Migration
  def self.up
    create_table :user_collections_users do |t| { :id => false }
		t.integer :user_collection_id
		t.integer :user_id

		t.timestamps
	end

    create_table :decisions_user_collections do |t| { :id => false }
		t.integer :decision_id
		t.integer :user_collection_id

		t.timestamps
	end

    create_table :decisions_tasks do |t| { :id => false }
		t.integer :decision_id
		t.integer :task_id

		t.timestamps
	end
  end

  def self.down
  	  drop_table :user_collections_users
  	  drop_table :decisions_user_collections
  	  drop_table :decisions_tasks
  end
end
