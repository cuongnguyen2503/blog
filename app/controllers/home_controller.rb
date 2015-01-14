class HomeController < ApplicationController
  def index
  	if logged_in?
    	@entry = current_user.entries.build  
    	@feed_items = current_user.feed.paginate(page: params[:page])
    else
    	@feed_items = Entry.paginate(page: params[:page])
    end
  end

  def help
  end
end
