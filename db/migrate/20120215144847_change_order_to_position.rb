class ChangeOrderToPosition < ActiveRecord::Migration
  def up
    rename_column :initiatives, :order, :position
  end

  def down
  end
end