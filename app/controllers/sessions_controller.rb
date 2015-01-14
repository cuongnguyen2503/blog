class SessionsController < ApplicationController
  
  def new
  end

  def create
  	user = User.find_by(email: params[:sessions][:email].downcase)
  	if user && user.authenticate(params[:sessions][:password])
  		flash[:success] = "sign in successful"
  		log_in user
  		redirect_back_or user
  	else
  		flash[:danger] = "Sign in error"
  		render 'new'
  	end
  end

  def destroy
  	log_out
  	redirect_to root_url
  end
end
