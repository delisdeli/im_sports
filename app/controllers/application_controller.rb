class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :check_for_notifications

  def check_for_notifications
    if params[:show_notifications]
      @show_notifications = true
      @user = User.find_by_id(params[:user_id])
      @user.read_messages
    end
  end

  def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      unless current_user and current_user.admin?
        flash[:notice] = "Must be admin user to access this feature"
        redirect_to(root_url)
      end
    end

    def correct_or_admin_user
      @user = User.find(params[:id])
      unless current_user?(@user) or (current_user and current_user.admin?)
        flash[:notice] = "You are not authorized to access this function"
        redirect_to(root_url)
      end
    end
end
