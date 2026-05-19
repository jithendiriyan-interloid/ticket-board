require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:unconfirmed_user) }
  it "creates as unconfirmed" do
    expect(user.confirmed?).to eq(false)
  end
  it "confirms account" do
    user.confirm
    expect(user.confirmed?).to eq(true)
  end
end
