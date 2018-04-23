# TODO refactor account number creation
class AccountController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = set_users if current_user.role? :owner
  end

  def remove 
    params[:id]= params[:id].to_i
     if(current_user.role?(:owner) && current_user.id != params[:id])
       user = set_users.find params[:id]
       if user
         user.roles.clear
         user.account = Account.create
         user.save!
         msg = 'User was removed from account.'
       end
     else
         msg = 'Owner cannot remove himself from account'
     end
     
     respond_to do |format|
       format.html { redirect_to account_index_url, notice: msg }
       format.json { head :no_content }
     end
  end
  
  private 
    def set_users
      current_user.account.users
    end
end
