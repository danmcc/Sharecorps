class TextChangeDecisionsController < ApplicationController

  def new
      @text_change_decision = TextChangeDecision.new( :target_field => params[:target_field] )
      @decision = Decision.new
      @project = Project.find(params[:project_id])
  end

  def create
    # TODO: add creator_user_id, project_id
    @project = Project.find(params[:project_id])
    @text_change_decision = TextChangeDecision.new(params[:text_change_decision])
    @text_change_decision.decision = Decision.new(
        params[:decision].merge(
            :project_id => @project.id
        )
    )

    respond_to do |format|
        if @text_change_decision.save
            flash[:notice] = 'Decision was successfully created.'
            format.html { redirect_to(project_path(@project)) }
            format.xml  { render :xml => @decision, :status => :created, :location => @decision }
        else
            format.html { render :action => "new" }
            format.xml  { render :xml => @decision.errors, :status => :unprocessable_entity }
		end
	end
  end
end
