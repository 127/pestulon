class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
   
  protected
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        respond_with_navigational(resource) { render :new }
      end 
    end
    
    def after_inactive_sign_up_path_for resource
      new_user_session_path
    end
end
