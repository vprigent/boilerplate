class AddAvatarGravityToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_gravity, :integer
  end
end
