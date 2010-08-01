class ChangeUserIdToShareholderIdAddNumSharesToVotes < ActiveRecord::Migration
  def self.up
    add_column :votes, :shareholder_id, :integer
    add_column :votes, :num_shares, :integer
    remove_column :votes, :user_id
  end

  def self.down
  end
end
