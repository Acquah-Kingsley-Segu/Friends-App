class RemoveSringFromFriends < ActiveRecord::Migration[7.0]
  def change
    remove_column :friends, :sring, :string
  end
end
