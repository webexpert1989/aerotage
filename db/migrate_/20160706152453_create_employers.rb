class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.string :company_name, limit: 100
      t.string :contact_name
      t.string :web_site, limit: 100
      t.string :phone_number, limit: 30
      t.text :company_description

      t.string :video_uid
      t.string :logo_uid
    end
  end
end
