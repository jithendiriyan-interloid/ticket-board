class UsersController < ApplicationController
   before_action :set_user
  def edit
  end

  def show
  end

  def destroy
    if @user.soft_delete!
      redirect_to root_path,  notice: t("users.deleted")
    else
      redirect_to edit_user_path(current_user), alert: t("users.delete_failed")
    end
  end

  def update
    @user.avatar.purge if params[:remove_avatar]
    if @user.update(profile_params)
      redirect_to root_path, notice: t("users.updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def set_user
    @user = current_user
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
      :pincode
    )
  end
end