class Api::UsersController < ApplicationController

  private

  def user_params
    attributes = model_attributes
    attributes.delete :password_digest
    params.require(:user).permit attributes << :password
  end

  def user_authorized
    @current_user.id == get_resource.id
  end

end
