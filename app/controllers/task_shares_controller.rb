class TaskSharesController < ApplicationController
  # GET /task_shares
  # GET /task_shares.xml
  def index
    @task_shares = TaskShare.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @task_shares }
    end
  end

  # GET /task_shares/1
  # GET /task_shares/1.xml
  def show
    @task_share = TaskShare.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task_share }
    end
  end

  # GET /task_shares/new
  # GET /task_shares/new.xml
  def new
    @task_share = TaskShare.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task_share }
    end
  end

  # GET /task_shares/1/edit
  def edit
    @task_share = TaskShare.find(params[:id])
  end

  # POST /task_shares
  # POST /task_shares.xml
  def create
  	@current_user_id = 1 # TODO: fix me

	# remove any existing entries
	TaskShare.destroy_all( :task_id => params[:task_share][:task_id], :user_id => @current_user_id )
	
    @task_share = TaskShare.new(
    	params[:task_share].merge({
    		:user_id => @current_user_id
		})
    )
	@task = Task.find(@task_share.task_id)
	@project = Project.find(@task.project_id)

    respond_to do |format|
      if @task_share.save
        flash[:notice] = 'You successfully offered ' + params[:task_share][:num_shares].to_s + ' of your shares for this task.';
        format.html { redirect_to([@project, @task]) }
        format.xml  { render :xml => @task_share, :status => :created, :location => @task_share }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @task_share.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /task_shares/1
  # PUT /task_shares/1.xml
  def update
    @task_share = TaskShare.find(params[:id])

    respond_to do |format|
      if @task_share.update_attributes(params[:task_share])
        flash[:notice] = 'TaskShare was successfully updated.'
        format.html { redirect_to(@task_share) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task_share.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /task_shares/1
  # DELETE /task_shares/1.xml
  def destroy
    @task_share = TaskShare.find(params[:id])

	@task = Task.find(@task_share.task_id)
	@project = Project.find(@task.project_id)

    @task_share.destroy

    respond_to do |format|
      flash[:notice] = 'You successfully deleted your offer of shares for this task.';
      format.html { redirect_to([@project, @task]) }
      format.xml  { head :ok }
    end
  end
end
