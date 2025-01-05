class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Great! Your user account has been created!"
      redirect_to new_user_path
    else
      # Log the validation errors
      Rails.logger.debug @user.errors.full_messages
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password ])
  end
end
