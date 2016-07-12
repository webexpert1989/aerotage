class AddNamesToFiles < ActiveRecord::Migration
  def change
    add_column :images, :image_name, :string
    add_column :videos, :video_name, :string
    remove_column :images, :thumb_uid, :string
  end
end
