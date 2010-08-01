class DecisionsController < ApplicationController
  # GET /decisions
  # GET /decisions.xml
  def index
    @decisions = Decision.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @decisions }
    end
  end

  # GET /decisions/1
  # GET /decisions/1.xml
  def show
    @decision = Decision.find(params[:id])
	@project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @decision }
    end
  end

  # GET /decisions/new
  # GET /decisions/new.xml
  def new
#    @decision = Decision.new
	@project = Project.find(params[:project_id])

#	if ! params[:decision].nil? && ! (@decision_type_id = params[:decision][:decision_type_id]).nil?
#		@decision_type_text_id = DecisionType.find(@decision_type_id).text_id
#		decision_type = @decision_type_text_id.camelize
#		@decision_detail = eval(decision_type + "Decision.new")
#	end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @decision }
    end
  end

  # GET /decisions/1/edit
  def edit
    @decision = Decision.find(params[:id])
  end

  # POST /decisions
  # POST /decisions.xml
  def create
  	# NB: this shouldn't get called -- the specific decision type controllers should get called
  	 
	# TODO: fix me
	@current_user_id = 1

    @decision = Decision.new(
    	params[:decision].merge({
    		creator_user_id => @creator_user_id
    	})
    )
	@project = Project.find(params[:project_id])

	respond_to do |format|
		#if params[:decision_type_id].nil?
		if @decision.decision_type_id.nil?
			format.html { render :action => "new" }
			format.xml  { render :xml => @decision.errors, :status => :unprocessable_entity }
		else
			decision_type_text_id = DecisionType.find(@decision.decision_type).text_id
			decision_type = decision_type_text_id.camelize
			@decision_detail = eval(decision_type + "Decision.new")

			if @decision_detail.summary
				if @decision.save && @decision_detail.save
					flash[:notice] = 'Decision was successfully created.'
					format.html { redirect_to(project_path(@project)) }
					format.xml  { render :xml => @decision, :status => :created, :location => @decision }
				else
					format.html { render :action => "new" }
					format.xml  { render :xml => @decision.errors, :status => :unprocessable_entity }
				end
			else
				format.html { render :action => "new" }
			end
		end
    end
  end

  # PUT /decisions/1
  # PUT /decisions/1.xml
  def update
    @decision = Decision.find(params[:id])

    respond_to do |format|
      if @decision.update_attributes(params[:decision])
        flash[:notice] = 'Decision was successfully updated.'
        format.html { redirect_to(@decision) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @decision.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /decisions/1
  # DELETE /decisions/1.xml
  def destroy
    @decision = Decision.find(params[:id])
    @decision.destroy

    respond_to do |format|
      format.html { redirect_to(decisions_url) }
      format.xml  { head :ok }
    end
  end

end
