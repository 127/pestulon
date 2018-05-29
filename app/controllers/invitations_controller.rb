# TODO fails to work. redo
class InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!
  def create
    super
    # User.where(email: params[:user][:email]).update_all(account_id: current_user.account.id)
    User.where(email: params[:user][:email]).update(role_ids: [3], account_id: current_user.account.id)
  end
  def after_invite_path_for resource
    new_invitation_path resource
  end
end
