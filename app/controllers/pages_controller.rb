class PagesController < ApplicationController
  def index
    if !params[:page]  && user_signed_in?
      redirect_to bills_path
    else 
      # @subscription = Subscription.new
      # params[:page] = params[:page] || 'index'
      render params[:page] || 'index'
    end
  end
end
