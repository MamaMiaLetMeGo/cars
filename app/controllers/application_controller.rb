class ApplicationController < ActionController::Base
  before_action :set_feature
  def set_feature
    # Grab makes that are featured to true and show them by newest
    @feature = Car.where(feature: true).order('created_at ASC')
  end
end
