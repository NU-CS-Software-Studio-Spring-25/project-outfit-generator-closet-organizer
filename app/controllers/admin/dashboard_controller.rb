class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @user_count = User.count
    @clothing_count = Clothing.count
    @admin_items_count = Clothing.where(user_id: nil).count
    @recent_users = User.order(created_at: :desc).limit(5)

    hidden_counts = HiddenClothing
      .group(:clothing_id)
      .order('count_all DESC')
      .limit(5)
      .count

    @most_hidden = Clothing.where(id: hidden_counts.keys).index_by(&:id).transform_values do |clothing|
      [clothing, hidden_counts[clothing.id]]
    end.values
  end

  private

  def require_admin
    redirect_to root_path, alert: "Not authorized." unless current_user.admin?
  end
end
