class AddYearToInitiatives < ActiveRecord::Migration
  def change
    add_column :initiatives, :year, :string
    add_column :initiatives, :proponent, :string
  end
end
