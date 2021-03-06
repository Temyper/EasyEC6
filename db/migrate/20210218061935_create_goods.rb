class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|

      t.integer :user_id, null: false
      t.text :image_id
      t.string :name, null: false, default: ""
      t.string :introduction, null: false, default: ""
      t.integer :value, null: false, default: 0
      

      t.timestamps
    end
  end
end
