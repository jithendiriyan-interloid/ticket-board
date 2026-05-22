require 'rails_helper'
RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  it "locks after maximum failed attempts" do
    Devise.maximum_attempts.times do
      user.increment_failed_attempts
    end
    user.lock_access!
    expect(user.access_locked?).to eq(true)
  end
end
