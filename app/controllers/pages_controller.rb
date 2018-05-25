class PagesController < ApplicationController
  def index
    if !params[:page]  && user_signed_in?
      # will cause test:system error if enabled here
      # redirect_to root_path
    else 
      @subscription = Subscription.new
      render params[:page] || 'index'
    end
  end
end
