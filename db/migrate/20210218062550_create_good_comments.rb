class CreateGoodComments < ActiveRecord::Migration[5.2]
  def change
    create_table :good_comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :good_id, null: false
      t.timestamps
    end
  end
end
