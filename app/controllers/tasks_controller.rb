class TasksController < ApplicationController
  # GET /tasks
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])

	@current_user_id = 1 # TODO: fix me
	@can_mark_as_abandoned = @task.requester_user_id == @current_user_id || @task.performer_user_id == @current_user_id
	@performer_not_yet_decided = @task.performer_user_id == 0
	@ready_to_decide_performer = 0 # TODO: fix me @task.
	@shares_available = self.get_shares_available( @project.id, @current_user_id )

	# always assume a new task_share; updating existing ones will delete previous ones
	@task_share = TaskShare.new( :task_id => @task.id )

	@all_task_shares = TaskShare.find_all_by_task_id( @task.id )

	@expand_share_pool_decision = ExpandSharePoolDecision.find_by_task_id( @task.id )
	@vote = Vote.new
	if ! @expand_share_pool_decision.nil?
		#@expand_share_pool_votes = Vote.find_all_by_decision_id( @expand_share_pool_decision.decision.id )
		@expand_share_pool_votes = @expand_share_pool_decision.decision.votes
	end

	if ! @task.decisions.nil? and ! @task.decisions.first.nil?
		@who_should_do_task_decision = @task.decisions.first.decidable # assume there's only one, and it's the first, for now; TODO: don't assume
	end

	@who_vote = Vote.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  def new
	@current_user_id = 1 # TODO: fix me

    @project = Project.find(params[:project_id])
    @task = Task.new
    @task.offered_or_wanted = params[:offered_or_wanted]

	@shares_available = self.get_shares_available( @project.id, @current_user_id )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  def get_shares_available(project_id, user_id)
	  shareholder = Shareholder.find_by_user_id_and_project_id( user_id, project_id )
	  pending_tasks = Task.find_all_by_requester_user_id_and_project_id_and_task_status_id( user_id, project_id, 1 ) # TODO: fix task status so it's "new or in progress"
	  shares_pending_transfer = pending_tasks.collect{ |t| t.num_shares }.sum
	  return shareholder.num_shares - shares_pending_transfer
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    # TODO: can this user create this task?
	@current_user_id = 1 # TODO: fix me

    @project = Project.find(params[:project_id])

	# make sure this user has the requested number of shares available
	@shares_available = self.get_shares_available( @project.id, @current_user_id )

	num_shares = params[:task][:num_shares]

	if (params[:task][:offered_or_wanted] == "wanted" \
		&& !num_shares.nil? \
		&& @shares_available < num_shares.to_i)
		#@task.errors.push("You only have " + @shares_available + " shares available to offer for tasks")
	end

    @task = Task.new(
		params[:task].merge({
			:requester_user_id => @current_user_id,
			:performer_user_id => params[:task][:offered_or_wanted] == "offered" ? @current_user_id : 0,
			:project_id => @project.id,
			:task_status_id => 1, # TODO: don't hardcode me
			:num_shares => num_shares
		})
    )

	@task.save # TODO: check for errors

	if @task.performer_user_id == 0 # this is a "wanted" task

		if params[:how_to_grant_shares] == "offer_own_shares"
			create_new_who_should_do_something_decision( @current_user_id, @task )
		elsif params[:how_to_grant_shares] == "group_vote_to_expand"
			create_new_expand_share_pool_decision( @current_user_id, @task, num_shares )
			# TODO: once the vote is done and it's approved, THEN we need a WhoShouldDoSomethingDecision
		else
			# error
		end

	else # this is an "offered" task
		create_new_expand_share_pool_decision( @current_user_id, @task, num_shares )
	end

    respond_to do |format|
      if @task.errors.empty? && @task.save
        flash[:notice] = 'Task was successfully created.'
        #format.html { redirect_to(@task) } # TODO: this needs to involve @project, too, somehow
        format.html { redirect_to(project_task_path(@project, @task)) } # does this work?
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def create_new_who_should_do_something_decision(current_user_id, task)
  	if task.instance_of? Fixnum # overload "task" a bit so we can use post_decision_handler, below, to just pass in an id
  		task = Task.find(task)
	end

	who_should_do_something_decision = WhoShouldDoSomethingDecision.new
	who_should_do_something_decision.decision = Decision.new(
		:creator_user_id => current_user_id,
		:summary => "Who should perform task " + task.name + "?",
		:project_id => task.project.id,
		:expiration_date => 0 # TODO: now + 14 days
	)
	# joined via decisions_tasks
	who_should_do_something_decision.decision.tasks = [ task ]

	who_should_do_something_decision.save # TODO: check for errors

	user_collection = UserCollection.new(
		:description => "Who should perform task " + task.id.to_s + "?"
	)

	# joined via decisions_user_collections
	user_collection.decisions = [ who_should_do_something_decision.decision ]
	user_collection.save
  end

  def create_new_expand_share_pool_decision(current_user_id, task, num_shares)
	  expand_share_pool_decision = ExpandSharePoolDecision.new( :task_id => task.id )
	  expand_share_pool_decision.decision = Decision.new(
		  :creator_user_id => current_user_id,
		  :summary => "Should we expand the share pool by " + num_shares + " shares for task " + task.name + "?",
		  :project_id => task.project.id,
		  :expiration_date => 0 # no expiration date for offered tasks?
	  )
	  expand_share_pool_decision.save # TODO: check for errors

	  expand_share_pool_decision.decision.post_decision_handler = PostDecisionHandler.new(
	  	  :expression => "DecisionsController.create_new_who_should_do_something_decision(" + current_user_id.to_s + ", " + task.id.to_s + ")"
	  )
  end

  def abandon
  	abandoned_status = TaskStatus.find_by_status("abandoned")
    task = Task.find(params[:id])
	task.task_status_id = abandoned_status.id

    respond_to do |format|
      if @task.errors.empty? && @task.save
        flash[:notice] = 'Task was abandoned.'
        format.html { redirect_to(project_task_path(@project, @task)) } 
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  def offer_to_do_work
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        flash[:notice] = 'Task was successfully updated.'
        format.html { redirect_to(@task) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
end
