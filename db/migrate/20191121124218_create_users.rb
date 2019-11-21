class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :email, null: false
    end
  end
end
