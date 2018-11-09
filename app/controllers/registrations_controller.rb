class RegistrationsController < DeviseTokenAuth::RegistrationsController

  private
  def sign_up_params
    params.permit(:name, :email, :password, :birthday, :gender)
  end

end