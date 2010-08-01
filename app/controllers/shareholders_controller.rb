class ShareholdersController < ApplicationController
  # GET /shareholders
  def index
    @shareholders = Shareholder.find_all_by_project_id(params[:project_id])
    @project = Project.find(params[:project_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @shareholders }
    end
  end

  # GET /shareholders/1
  def show
    @shareholder = Shareholder.find_by_id_and_project_id(params[:id], params[:project_id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @shareholder }
    end
  end

  # GET /shareholders/new
  def new
    @shareholder = Shareholder.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @shareholder }
    end
  end

  # GET /shareholders/1/edit
  def edit
    @shareholder = Shareholder.find(params[:id])
  end

  # POST /shareholders
  # POST /shareholders.xml
  def create
    @shareholder = Shareholder.new(params[:shareholder])

    respond_to do |format|
      if @shareholder.save
        flash[:notice] = 'Shareholder was successfully created.'
        format.html { redirect_to(@shareholder) }
        format.xml  { render :xml => @shareholder, :status => :created, :location => @shareholder }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @shareholder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /shareholders/1
  # PUT /shareholders/1.xml
  def update
    @shareholder = Shareholder.find(params[:id])

    respond_to do |format|
      if @shareholder.update_attributes(params[:shareholder])
        flash[:notice] = 'Shareholder was successfully updated.'
        format.html { redirect_to(@shareholder) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shareholder.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /shareholders/1
  # DELETE /shareholders/1.xml
  def destroy
    @shareholder = Shareholder.find(params[:id])
    @shareholder.destroy

    respond_to do |format|
      format.html { redirect_to(shareholders_url) }
      format.xml  { head :ok }
    end
  end
end
