# TODO check this http://blog.jex.tw/blog/2015/04/12/rails-user/

class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
   
  private
  
    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        respond_with resource, location: new_user_session_path
      end 
    end
    
    def after_inactive_sign_up_path_for resource
      new_user_session_path
    end
end
