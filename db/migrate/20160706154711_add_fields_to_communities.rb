class AddFieldsToCommunities < ActiveRecord::Migration
  def change
    add_column :communities, :brief_description, :string
    add_column :communities, :specialties, :string
    add_column :communities, :content, :text
    add_column :communities, :content_raw, :text
    add_column :communities, :image_uid, :string
    add_column :communities, :content_title, :string
  end
end
