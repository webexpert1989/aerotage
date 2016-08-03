class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string   "video_uid"

      t.references :videoable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
