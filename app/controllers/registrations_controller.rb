class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :phone_no, :address, :avatar)
  end

  def account_update_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :lastname, :phone_no, :address, :avatar, :current_password)
  end

end