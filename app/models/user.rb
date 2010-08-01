class User < ActiveRecord::Base
  has_many :performer_tasks, :class_name => "Task", :foreign_key => "performer_user_id"
  has_many :requester_tasks, :class_name => "Task", :foreign_key => "requester_user_id"
  has_many :creator_decisions, :class_name => "Decision", :foreign_key => "creator_user_id"
  has_many :task_shares
  has_many :votes
  has_many :shareholders
  has_and_belongs_to_many :user_collections

  validates_presence_of :username
  validates_length_of :username, :within => 1..50
  validates_uniqueness_of :username

  # we intentionally allow multiple usernames with the same email
  # so that people can be associated with multiple projects using
  # different usernames if they'd like
  validates_presence_of :email
  validates_length_of :email, :within => 1..50

  validates_presence_of :first_name
  validates_length_of :first_name, :within => 1..50

  validates_presence_of :last_name
  validates_length_of :last_name, :within => 1..50

  #validates_presence_of :password
end
