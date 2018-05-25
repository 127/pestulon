class SubscriptionsController < ApplicationController

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end
  
  def show
    @subscription = Subscription.find params[:id]
  end
  # POST /subscriptions
  # POST /subscriptions.json
  def create
    @subscription = Subscription.new subscription_params

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Subscription was successfully created.' }
        # format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        # format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:email, :name)
    end
end
