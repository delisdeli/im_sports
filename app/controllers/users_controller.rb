class UsersController < ApplicationController
  before_filter :correct_or_admin_user, only: [:edit, :update]
  before_filter :admin_user, only: [:destroy, :index]
  before_filter :correct_user, only: [:clear_notifications]
  before_filter :set_user, only: [:show, :clear_notifications, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @invites = []
    if current_user?(@user)
      @invites = @user.invitations
      @notifications = @user.notifications
      @user.read_messages
    end
  end

  def clear_notifications
    @user.clear_notifications
    redirect_to @user
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    params[:user][:has_new_message] = false
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @user.update_attributes(params[:user])
      # Handle a successful update.
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    redirect_to users_path
  end

  def set_user
    begin
      @user = User.find(params[:id])
    rescue
    end
    redirect_to root_url, notice: "That user doesn't exist" unless @user
  end
end
