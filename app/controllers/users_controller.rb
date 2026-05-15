class UsersController < ApplicationController
  def new
    @user = current_user
  end

  def create
    @user = current_user

    if @user.update(profile_params)
    puts "Saved successfully"
    puts @user.reload.inspect
      redirect_to root_path, notice: "Profile saved successfully"
    else
      puts @user.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = current_user
  end
  def show
    @user = current_user
  end
  def update
    @user = current_user

    if @user.update(profile_params)
      redirect_to root_path, notice: "Profile updated successfully"
    else
      puts @user.errors.full_messages
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
      :avatar
    )
  end
end