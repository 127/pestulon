# TODO check this http://blog.jex.tw/blog/2015/04/12/rails-user/

class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  # def create
  #   if verify_recaptcha
  #     super
  #   else
  #     build_resource(sign_up_params)
  #     clean_up_passwords(resource)
  #     flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."
  #     flash.delete :recaptcha_error
  #     render :new
  #   end
  # end

  private
    def after_inactive_sign_up_path_for resource
      new_user_session_path
    end

    def check_captcha
      unless verify_recaptcha
        self.resource = resource_class.new sign_up_params
        resource.validate # Look for any other validation errors besides Recaptcha
        set_minimum_password_length
        respond_with resource 
        #, location: new_user_session_path
        # self.resource = resource_class.new
        # resource.validate # Look for any other validation errors besides Recaptcha
        # respond_with_navigational(resource) { render :new }
      end
    end
    
    
end
