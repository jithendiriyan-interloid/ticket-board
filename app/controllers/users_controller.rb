class UsersController < ApplicationController

  def edit
  end

  def show
  end

  def destroy
    if current_user.soft_delete!
      redirect_to root_path,  notice: "Account was deleted successfully"
    else
      redirect_to edit_user_path(current_user), alert: "Unable to delete"
    end
  end
  def update
    if ActiveModel::Type::Boolean.new.cast(params.dig(:user, :remove_avatar))
      current_user.avatar.purge
    end
    if current_user.update(profile_params.except(:remove_avatar))
      redirect_to edit_user_path(current_user), notice: "Profile updated successfully"
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
      :pincode
    )
  end
end
