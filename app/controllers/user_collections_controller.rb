class UserCollectionsController < ApplicationController
  def update
    user_collection = UserCollection.find(params[:id])
    add_user_id = User.find(params[:add_user_id])

	if ! user_collection.users.grep add_user_id
		user_collection.users.push( add_user_id ) # TODO: assume current_user_id, or make hack-proof
	end

	@task = user_collection.decisions.first.tasks.first

    respond_to do |format|
        flash[:notice] = "Ok, you're now in the running to do this task."
        format.html { redirect_to([@task.project, @task]) }
        format.xml  { head :ok }
    end
  end

end
