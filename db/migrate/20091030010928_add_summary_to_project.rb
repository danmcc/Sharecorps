class AddSummaryToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :summary, :string
  end

  def self.down
    remove_column :projects, :summary
  end
end
