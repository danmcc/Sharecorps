class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_status
  belongs_to :requester_user, :class_name => "User"
  belongs_to :performer_user, :class_name => "User"
  has_and_belongs_to_many :decisions

  validates_presence_of :name
  validates_presence_of :description
  validates_numericality_of :days_to_complete
  validates_numericality_of :num_shares
end
