class AddDefendersFieldsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :spam, :boolean
    add_column :comments, :defensio_sig, :string
    add_column :comments, :spaminess, :float
  end
end
