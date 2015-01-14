class EntriesController < ApplicationController
	# Authorization
	before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
	# Destroy au
	before_action :correct_user, only: [:destroy, :edit, :update]
	# Show all entries 
	def index
		@entries = Entry.paginate(page: params[:page])
	end

	# Create entry
	def create
		@entry = current_user.entries.build(entry_params)
		if @entry.save
			flash[:success] = "Create successfully"
			redirect_to root_url
		else
			flash[:alert] = "Create unsuccessfully"
			redirect_to root_url
		end
	end

	# Destroy enty
	def destroy
		@entry.destroy
		flash[:success] = "Entry was deleted."
		redirect_to root_url
	end

	# Show entry
	def show
		@entry = Entry.find(params[:id])
		@comment = @entry.comments
	end

	# Edit entry
	def edit
		@entry = Entry.find(params[:id])
	end

	# Update edit entry
	def update
  	@entry = Entry.find(params[:id])
  	if @entry.update_attributes(entry_params)
  		flash[:success] = "Update successful"
  		redirect_to entry_url
  	else
  		render 'edit'
  	end
	end

  private

    def entry_params
      params.require(:entry).permit(:title, :body)
    end	

    def correct_user 
    	@entry = current_user.entries.find_by(id: params[:id])
    	redirect_to root_url if @entry.nil?
    end
end
