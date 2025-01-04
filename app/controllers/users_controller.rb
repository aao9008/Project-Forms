class UsersController < ApplicationController
  def new
    # Code for displaying the user form will go here
  end

  def create
    @user = User.new(username: params[:user][:username], email: params[:user][:email], password: params[:user][:password])

    if @user.save
      redirect_to new_user_path
    else
      # Log the validation errors
      Rails.logger.debug @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end
end
