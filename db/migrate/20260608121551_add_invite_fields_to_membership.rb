class AddInviteFieldsToMembership < ActiveRecord::Migration[8.1]
  def change
    add_column :memberships, :token, :string
    add_column :memberships, :status, :integer
  end
end
