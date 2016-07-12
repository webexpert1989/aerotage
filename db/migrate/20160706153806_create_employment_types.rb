class CreateEmploymentTypes < ActiveRecord::Migration
  def change
    create_table :employment_types do |t|
      t.string :title
    end

    create_table :employment_types_listings, id: false do |t|
      t.belongs_to :employment_type
      t.belongs_to :listing
    end
  end
end
