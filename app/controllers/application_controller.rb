class ApplicationController < ActionController::Base
  before_action :set_feature
  helper_method :is_admin!
  def set_feature
    # Grab makes that are featured to true and show them by newest
    @feature = Car.where(feature: true).order('created_at ASC')
  end


  def is_admin!
    unless current_user&.admin
      redirect_to root_path
    end
  end
end