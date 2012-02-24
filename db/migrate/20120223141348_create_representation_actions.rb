class CreateRepresentationActions < ActiveRecord::Migration
  def change
    create_table :representation_actions do |t|
      t.text :name
      t.text :url
      t.integer :representative_id

      t.timestamps
    end
  end
end
