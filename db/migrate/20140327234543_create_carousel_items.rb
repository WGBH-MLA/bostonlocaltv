class CreateCarouselItems < ActiveRecord::Migration
  def change
    create_table :carousel_items do |t|
      t.string :title
      t.text :body
      t.string :url
      t.string :image
      t.boolean :enabled, default: false
      t.integer :position
      t.timestamps
    end
  end
end
