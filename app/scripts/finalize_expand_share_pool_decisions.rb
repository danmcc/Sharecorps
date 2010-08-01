class FinalizeExpandSharePoolDecisions
	# TODO: at any point if more than 50% of votes are in favor or against, just finalize the decision

	# TODO: I think we have to go through Decision to find expiration date?
	expand_pool_decisions = ExpandSharePoolDecision.find( :all )

	expand_pool_decisions.each do |expand_pool_decision|
		print "Pool: ", expand_pool_decision.id, "\n"

		decision = expand_pool_decision.decision

		print "Decision: ", decision.id, "\n"

		# add up the votes -- this should probably go into Decision
		yes_votes = 0
		expand_pool_decision.decision.votes.each{ |v| yes_votes = yes_votes + v.num_shares if v.choice == "Yes" }

		no_votes = 0
		expand_pool_decision.decision.votes.each{ |v| no_votes = no_votes + 1 if v.choice == "No" }

		result = yes_votes > no_votes ? "Yes" : "No"

		print "Result: yes[", yes_votes, "] no[", no_votes, "] ", result, "\n"
		#pool_decisions.decision.result = result

		# if Yes and it's part of a WhoShouldDoSomethingDecision, do that
	end
end
