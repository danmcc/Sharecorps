class Decision < ActiveRecord::Base
  belongs_to :project
  belongs_to :creator_user, :class_name => "User"
  belongs_to :decidable, :polymorphic => true
  has_and_belongs_to_many :tasks # are we sure all decisions have tasks?
  has_and_belongs_to_many :user_collections
  has_many :votes
  has_one :post_decision_handler

  # a decision is ready to finalize if the sum of votes cast by shareholders is greater than 50% of total shares
  def ready_to_finalize
  	  votes_cast = 0
  	  self.votes.each{ |v| votes_cast = votes_cast + v.num_shares }

  	  if votes_cast > 0.5 * self.project.total_shares
  	  	  return true
	  end
  end

  def attempt_to_finalize
  	  if self.ready_to_finalize
  	  	  self.finalize_decision
  	  end
  end

  def finalize_decision
	  vote_count = {}
	  self.votes.each{ |v| vote_count[v.choice] ||= 0; vote_count[v.choice] += v.num_shares }

	  result = vote_count.sort{ |a,b| a[1] <=> b[1] }.first[0]
	  self.result = result
	  self.save

	  if (!self.post_decision_handler.nil?) 
	  	  	eval(self.post_decision_handler.expression)
	  end

  end

end
