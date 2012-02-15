class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.text :title
      t.text :url
      t.integer :representative_id

      t.timestamps
    end
  end
end
