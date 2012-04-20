class AddFollowingToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :following, :boolean
  end
end
