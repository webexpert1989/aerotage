class RemoveFileColumnsFromAllModels < ActiveRecord::Migration
  def change
    remove_column :employers, :logo_uid, :string
    remove_column :employers, :video_uid, :string
    remove_column :job_seekers, :profile_picture_uid, :string
    remove_column :communities, :image_uid, :string
  end
end