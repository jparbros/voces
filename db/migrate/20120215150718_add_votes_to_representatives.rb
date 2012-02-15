class AddVotesToRepresentatives < ActiveRecord::Migration
  def change
    add_column :representatives, :number_votes, :integer
  end
end
