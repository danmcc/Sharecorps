class ExpandSharePoolDecision < ActiveRecord::Base
	belongs_to :task
	has_one :decision, :as => :decidable
	accepts_nested_attributes_for :decision
end
