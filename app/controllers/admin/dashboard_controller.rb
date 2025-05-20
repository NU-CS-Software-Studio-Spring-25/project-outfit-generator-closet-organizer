class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    # Admin-only data can be set here
    @user_count = User.count
    @clothing_count = Clothing.count
    @recent_users = User.order(created_at: :desc).limit(5)
  end

  private

  def require_admin
    redirect_to root_path, alert: "Not authorized." unless current_user.admin?
  end
end
