class UsersController < ApplicationController
  before_action :set_user, only: %i[ update ]
  def profile
    @user = current_user
  end
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_profile_path, notice: "Profile was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :show, status: :unprocessable_user }
        format.json { render json: @user.errors, status: :unprocessable_user }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :ci, :address, :address_two, :city, :birthday, :phone)
  end
end
