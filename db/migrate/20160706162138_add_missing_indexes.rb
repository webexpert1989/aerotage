class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :communities_listings, [:community_id, :listing_id], unique: true
    add_index :communities_listings, [:listing_id, :community_id]

    add_index :employment_types_listings, [:listing_id, :employment_type_id], name: 'index_employment_types', unique: true

    add_index :listings_occupations, [:listing_id, :occupation_id], unique: true

    add_index :jobs, :employer_id
    add_index :resumes, :job_seeker_id

    add_index :listings, :location_id
    add_index :users, :location_id

    add_index :locations, :city
    add_index :locations, :state
    add_index :locations, :country
    add_index :locations, :zip_code

    add_index :saved_jobs, :job_seeker_id
    add_index :saved_jobs, [:job_id, :job_seeker_id], unique: true

    add_index :saved_resumes, :employer_id
    add_index :saved_resumes, [:resume_id, :employer_id], unique: true

    add_index :screening_questionnaires, :employer_id

    add_index :searches, :user_id
    add_index :searches, :token, unique: true

    add_index :users, [:actable_id, :actable_type]
    add_index :listings, [:actable_id, :actable_type]
  end
end
