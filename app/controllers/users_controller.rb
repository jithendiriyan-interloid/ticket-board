class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def show
    @user = current_user
  end

  def destroy
    if current_user.soft_delete!
      sign_out(current_user)
      redirect_to root_path, notice: "Account was deleted successfully"
    else
      redirect_to edit_user_path(current_user), alert: "Unable to delete"
    end
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      redirect_to root_path, notice: "Profile updated successfully"
    else
      render :edit, status: :unprocessable_entity
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
      :pin
    )
  end
end