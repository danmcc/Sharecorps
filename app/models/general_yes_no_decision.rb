class GeneralYesNoDecision < ActiveRecord::Base
	has_one :decision, :as => :decidable
	accepts_nested_attributes_for :decision
end
