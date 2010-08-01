class GeneralMultipleChoiceDecisionsController < ApplicationController
  def new
	  @general_multiple_choice_decision = GeneralMultipleChoiceDecision.new
	  @decision = Decision.new
	  @project = Project.find(params[:project_id])
  end

  def create
	# TODO: fix me
	@current_user_id = 1

	@project = Project.find(params[:project_id])
    @general_multiple_choice_decision = GeneralMultipleChoiceDecision.new(params[:general_multiple_choice_decision])
    @general_multiple_choice_decision.decision = Decision.new(
    	params[:decision].merge(
    		:project_id => @project.id,
    		:creator_user_id => @current_user_id
    	)
    )

	respond_to do |format|
		if @general_multiple_choice_decision.save
			n = 1
			while !params["option" + n.to_s].nil? and params["option" + n.to_s] != ""
				multiple_choice_option = MultipleChoiceOption.new(
					:general_multiple_choice_decision_id => @general_multiple_choice_decision.id,
					:option => params["option" + n.to_s]
				)
				n = n + 1
				multiple_choice_option.save
			end

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

    @general_multiple_choice_decision = GeneralMultipleChoiceDecision.find(params[:id])
    @decision = @general_multiple_choice_decision.decision
	@project = Project.find(params[:project_id])

	@multiple_choice_options = MultipleChoiceOption.find_all_by_general_multiple_choice_decision_id( @general_multiple_choice_decision.id );

	shareholder = Shareholder.find_by_user_id_and_project_id( @current_user_id, @decision.project_id )
	@my_vote = Vote.find_by_decision_id_and_shareholder_id(@decision.id, shareholder)
	@vote = Vote.new
	@all_votes = Vote.find_all_by_decision_id(@decision.id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @decision }
    end
  end

end
