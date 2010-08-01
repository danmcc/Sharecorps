class GeneralMultipleChoiceDecision < ActiveRecord::Base
	has_one :decision, :as => :decidable
	has_many :multiple_choice_options
	accepts_nested_attributes_for :decision
end
