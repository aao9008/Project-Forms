class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    # @user = User.new(username: params[:username], email: params[:email], password: params[:password])

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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "User details have been updated!"
      redirect_to edit_user_path
    else
      Rails.logger.debug @user.errors.full_messages
      flash.now[:error] = "Rats! Fix your mistakes, please."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [ :username, :email, :password ])
  end
end
