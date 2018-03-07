class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]

  private
    def check_captcha
      unless verify_recaptcha
        self.resource = User.new sign_up_params
        resource.validate
        respond_with_navigational(resource) { render :new }
      end
    end
end
