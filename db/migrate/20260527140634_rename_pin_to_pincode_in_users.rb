class RenamePinToPincodeInUsers < ActiveRecord::Migration[8.1]
  def change
     rename_column :users, :pin, :pincode
  end
end
