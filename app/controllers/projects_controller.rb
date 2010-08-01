class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    task_status_id = 1 # TaskStatus.new("not started or in progress";

	session_user_id = 1
	if @project.shareholders.map{ |user| user.id }.include?(session_user_id)
		@user_is_a_shareholder = true
	end

    # can we base this off @project?
    @current_work_wanted = Task.find(
		:all,
		:conditions => {
			:project_id => @project.id,
			:task_status_id => task_status_id,
			:offered_or_wanted => "wanted"
		}
    )
    @current_work_offered = Task.find(
		:all,
		:conditions => {
			:project_id => @project.id,
			:task_status_id => task_status_id,
			:offered_or_wanted => "offered"
		}
    )
    @past_work = Task.find(
	:all,
	:conditions => {
		:project_id => @project.id,
		:task_status_id => "'completed' or 'abandoned'"
	}
    )

    @current_decisions = Decision.find(
		:all,
		:conditions => {
			:project_id => @project.id,
			:result => nil
		}
    )

    @past_decisions = Decision.find(
		:all,
		:conditions => {
			:project_id => @project.id,
			:result => "approved" # TODO fixme
		}
    );

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
	  @current_user_id = 1 # TODO: fix me

    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'

        Shareholder.new({
			user_id => @current_user_id,
			project_id => @project.id,
			num_shares => @project.num_shares
		});

        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
