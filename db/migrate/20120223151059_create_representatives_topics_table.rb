class CreateRepresentativesTopicsTable < ActiveRecord::Migration

  def up
    create_table :representatives_topics, :id => false do |t|
      t.integer :representative_id
      t.integer :topic_id
    end
  end

  def down
  end
end