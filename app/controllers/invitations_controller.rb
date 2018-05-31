class InvitationsController < Devise::InvitationsController
  before_action :authenticate_user!

  def after_invite_path_for resource
    new_invitation_path resource
  end
end
