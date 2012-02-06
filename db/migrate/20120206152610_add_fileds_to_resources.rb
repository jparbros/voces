class AddFiledsToResources < ActiveRecord::Migration
  def change
    add_column :resources, :resoursable_type, :string
    add_column :resources, :resoursable_id, :integer
  end
end
