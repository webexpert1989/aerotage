class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string   "image_uid"
      t.string   "thumb_uid"

      t.references :imageable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
