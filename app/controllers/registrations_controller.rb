class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
   
  private
  
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        puts resource
        respond_with resource
        # self.resource = resource_class.new sign_up_params
        # respond_with_navigational(resource) { render :new }
      end 
    end
    
    def after_inactive_sign_up_path_for resource
      new_user_session_path
    end
end
