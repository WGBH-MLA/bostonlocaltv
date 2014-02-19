class CreateDigActions < ActiveRecord::Migration
  def change
    create_table :dig_actions do |t|
      t.integer :user_item_id
      t.integer :admin_user_id
      t.string :type

      t.timestamps
    end
  end
end
