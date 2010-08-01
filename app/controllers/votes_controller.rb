class VotesController < ApplicationController
  def create
	# TODO: fix me
	@current_user_id = 1
	@decision = Decision.find(params[:decision_id])
	shareholder = Shareholder.find_by_user_id_and_project_id( @current_user_id, @decision.project_id )

	Vote.destroy_all( :decision_id => params[:decision_id], :shareholder_id => shareholder )

	@project = Project.find(@decision.project_id)
    @vote = Vote.new(
    	:decision_id => @decision.id,
    	:choice      => params[:choice],
#		:user_id     => @current_user_id
		:shareholder_id => shareholder.id,
		:num_shares  => shareholder.num_shares # this can change over time, so we want to record the present num_shares
	)

	# TODO:
	# @decision.attempt_to_finalize # except @decision is the model object, not the controller, so...
	# DecisionController.attempt_to_finalize(@decision)?
	# or does that belong in the model?

	respond_to do |format|
		if @vote.save
			flash[:notice] = 'Vote was successfully created.'
			format.html { redirect_to(project_path(@project)) }
			format.xml  { render :xml => @vote, :status => :created, :location => @vote }
		else
			format.html { render :action => "new" }
			format.xml  { render :xml => @vote.errors, :status => :unprocessable_entity }
		end
    end
  end

end
