class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.text :name
      t.text :url

      t.timestamps
    end
  end
end
