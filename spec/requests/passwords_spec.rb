require 'rails_helper'
RSpec.describe "Password Reset", type: :request do
  let!(:user) { create(:user) }
  it "sends reset password instructions" do
    post user_password_path, params: {
      user: {
        email: user.email
      }
    }
    expect(response).to have_http_status(:see_other)
    user.reload
    expect(user.reset_password_token).not_to be_nil
  end
end
