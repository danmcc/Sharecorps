class GeneralYesNoDecisionsController < ApplicationController
  def new
	  @general_yes_no_decision = GeneralYesNoDecision.new
	  @decision = Decision.new
	  @project = Project.find(params[:project_id])
  end

  def create
	# TODO: fix me
	@current_user_id = 1

	@project = Project.find(params[:project_id])
    @general_yes_no_decision = GeneralYesNoDecision.new(params[:general_yes_no_decision])
    @general_yes_no_decision.decision = Decision.new(
    	params[:decision].merge(
    		:project_id => @project.id,
    		:creator_user_id => @current_user_id
    	)
    )

	respond_to do |format|
		if @general_yes_no_decision.save
			flash[:notice] = 'Decision was successfully created.'
			format.html { redirect_to(project_path(@project)) }
			format.xml  { render :xml => @decision, :status => :created, :location => @decision }
		else
			format.html { render :action => "new" }
			format.xml  { render :xml => @decision.errors, :status => :unprocessable_entity }
		end
    end
  end

  def show
	# TODO: fix me
	@current_user_id = 1

    @general_yes_no_decision = GeneralYesNoDecision.find(params[:id])
    @decision = @general_yes_no_decision.decision
	@project = Project.find(params[:project_id])
	shareholder = Shareholder.find_by_user_id_and_project_id( @current_user_id, @decision.project_id )
	@my_vote = Vote.find_by_decision_id_and_shareholder_id(@decision.id, shareholder.id)
	@all_votes = Vote.find_all_by_decision_id(@decision.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @decision }
    end
  end

end
