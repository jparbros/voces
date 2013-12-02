class AddFieldToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :main_at, :datetime
  end
end
