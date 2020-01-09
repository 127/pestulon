class Admin::AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_auth

  private

  def check_auth
    if !current_user.role? :admin
      render 'shared/prohibited'
    end
  end
end