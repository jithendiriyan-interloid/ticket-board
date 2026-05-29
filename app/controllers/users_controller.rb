class UsersController < ApplicationController
  def edit
    @user = current_user
    authorize @user
    if current_user.owner?
        @users = User.all
    end
  end

  def show
    @user = current_user
    authorize @user
  end

  def destroy
    @user = current_user
    authorize @user
    if current_user.soft_delete!
      sign_out(current_user)
      redirect_to root_path, notice: "Account was deleted successfully"
    else
      redirect_to edit_user_path(current_user), alert: "Unable to delete"
    end
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update(profile_params)
      redirect_back(
        fallback_location: root_path,
        notice: "User updated successfully"
      )
    else
      redirect_back(
        fallback_location: root_path,
        alert: "Unable to update user"
      )
    end
  end

  private
  def profile_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :phone,
      :state,
      :city,
      :street,
      :avatar,
      :remove_avatar,
      :role
    )
  end
end