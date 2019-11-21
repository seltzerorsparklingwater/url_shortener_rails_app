class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.timestamps

      t.integer :user_id, null: false
      t.integer :shortened_url_id, null: false
    end
    add_index :visits, :user_id
    add_index :visits, :shortened_url_id
  end
end
