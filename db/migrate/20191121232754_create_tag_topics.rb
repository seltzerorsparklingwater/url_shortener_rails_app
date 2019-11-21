class CreateTagTopics < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_topics do |t|
      t.timestamps

      t.string :name, null: false
    end
  end
end
