class UsersController < ApplicationController
   before_action :set_user
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
<<<<<<< HEAD
    if params[:remove_avatar]
      @user.avatar.purge
    elsif params.dig(:user, :avatar).present?
      @user.update(avatar: params[:user][:avatar])
    else
      @user.update(profile_params)
=======
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
>>>>>>> 195d62b (Pundit authorization function added)
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
