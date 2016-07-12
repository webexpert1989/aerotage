class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :title, limit: 100
    end

    create_table :communities_listings, id: false do |t|
      t.belongs_to :community
      t.belongs_to :listing
    end
  end
end
