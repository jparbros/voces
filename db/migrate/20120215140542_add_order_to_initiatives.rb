class AddOrderToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :order, :integer
  end
end
