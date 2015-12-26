class Api::RoomsController < ApplicationController
  before_action :authenticate, only: [:index, :create, :show]

  private

  def room_params
    attributes = model_attributes
    attributes.delete :user
    args = params.require(:room).permit attributes
    args[:user] = @current_user
    return args
  end

  def user_authorized
    @current_user == get_resource.user
  end

end
