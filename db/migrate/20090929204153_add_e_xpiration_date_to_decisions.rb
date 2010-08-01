class AddEXpirationDateToDecisions < ActiveRecord::Migration
  def self.up
    add_column :decisions, :expiration_date, :date
  end

  def self.down
    remove_column :decisions, :expiration_date
  end
end
