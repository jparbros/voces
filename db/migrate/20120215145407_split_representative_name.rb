class SplitRepresentativeName < ActiveRecord::Migration
  def up
    rename_column :representatives, :name, :first_name
    add_column :representatives, :last_name, :string
  end

  def down
  end
end