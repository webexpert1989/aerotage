class AddCoverLetterRawToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :cover_letter_raw, :text
  end
end
