require 'rails_helper'
RSpec.describe User, type: :model do
  it "is valid with proper attributes" do
    user = build(:user)
    expect(user).to be_valid
  end
  it "requires unique email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")
    expect(user).not_to be_valid
  end
  it "rejects weak password" do
    user = build(:user, password: "abc123")
    expect(user).not_to be_valid
  end
end
