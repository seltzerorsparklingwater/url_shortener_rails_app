class CreateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :taggings do |t|
      t.timestamps

      t.integer :tag_topic_id, null: false
      t.integer :shortened_url_id, null: false
    end
    add_index :taggings, %i(tag_topic_id shortened_url_id), unique: true
    add_index :taggings, :shortened_url_id
  end
end
