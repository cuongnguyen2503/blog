class CommentsController < ApplicationController

	# Authorization 
	before_action :logged_in_user, only: [:create]

	def create 
		@entry = Entry.find(params[:entry_id])
		@comment = current_user.comments.create(comment_params)
		@comment.entry_id = @entry.id
		if @comment.save
			flash[:success] = "Comment posted"
			redirect_to entry_path(@entry)
		else
			flash[:alert] = "Comment unsuccessful"
			redirect_to root_url
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:user_id, :body)
		end

end
