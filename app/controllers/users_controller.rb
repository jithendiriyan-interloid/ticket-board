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

  def destroy
    if current_user.soft_delete!
      sign_out(current_user)
      redirect_to root_path, notice: "Account was deleted successfully"
    else
      redirect_to edit_user_path(current_user), alert: "Unable to delete"
    end
  end

  def update
    if params[:remove_avatar]
      @user.avatar.purge
    elsif params.dig(:user, :avatar).present?
      @user.update(avatar: params[:user][:avatar])
    else
      @user.update(profile_params)
    end
      respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("profile_picture", partial: "users/profile_picture")
      end
        format.html { render :edit }
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
<<<<<<< HEAD
      :pincode
=======
      :pin
>>>>>>> 82166d6 (Userprofile section UI Updated)
    )
  end
end
