# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160804101241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "cube"
  enable_extension "earthdistance"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "applications", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "job_id"
    t.text     "cover_letter"
    t.text     "questionnaire"
    t.integer  "status",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "cover_letter_raw"
  end

  add_index "applications", ["job_id"], name: "index_applications_on_job_id", using: :btree
  add_index "applications", ["resume_id"], name: "index_applications_on_resume_id", using: :btree

  create_table "blog_post_comments", force: :cascade do |t|
    t.integer  "commenter_id"
    t.string   "commenter_type"
    t.integer  "blog_post_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_comment_id"
  end

  add_index "blog_post_comments", ["blog_post_id"], name: "index_blog_post_comments_on_blog_post_id", using: :btree
  add_index "blog_post_comments", ["commenter_type", "commenter_id"], name: "index_blog_post_comments_on_commenter_type_and_commenter_id", using: :btree
  add_index "blog_post_comments", ["parent_comment_id"], name: "index_blog_post_comments_on_parent_comment_id", using: :btree

  create_table "blog_posts", force: :cascade do |t|
    t.string   "title",        limit: 100, null: false
    t.text     "body"
    t.string   "author"
    t.integer  "community_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body_raw"
    t.text     "summary"
    t.text     "summary_raw"
    t.string   "slug",                     null: false
  end

  add_index "blog_posts", ["community_id"], name: "index_blog_posts_on_community_id", using: :btree
  add_index "blog_posts", ["slug"], name: "index_blog_posts_on_slug", unique: true, using: :btree

  create_table "communities", force: :cascade do |t|
    t.string "title",             limit: 100, null: false
    t.string "slug",                          null: false
    t.string "brief_description"
    t.string "specialties"
    t.text   "content"
    t.text   "content_raw"
    t.string "content_title"
  end

  add_index "communities", ["slug"], name: "index_communities_on_slug", unique: true, using: :btree

  create_table "communities_listings", id: false, force: :cascade do |t|
    t.integer "community_id"
    t.integer "listing_id"
  end

  add_index "communities_listings", ["community_id", "listing_id"], name: "index_communities_listings_on_community_id_and_listing_id", unique: true, using: :btree
  add_index "communities_listings", ["listing_id", "community_id"], name: "index_communities_listings_on_listing_id_and_community_id", using: :btree

  create_table "documents", force: :cascade do |t|
    t.string   "document_uid"
    t.string   "document_name"
    t.integer  "documentable_id"
    t.string   "documentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documents", ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id", using: :btree

  create_table "educations", force: :cascade do |t|
    t.date     "entrance_date"
    t.date     "graduation_date"
    t.string   "institution_name"
    t.string   "major"
    t.string   "degree_level"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["resume_id"], name: "index_educations_on_resume_id", using: :btree

  create_table "employers", force: :cascade do |t|
    t.string   "company_name",                 limit: 100, null: false
    t.string   "contact_name"
    t.string   "web_site",                     limit: 100
    t.string   "phone_number",                 limit: 30
    t.text     "company_description"
    t.text     "company_description_raw"
    t.datetime "featured_last_shown"
    t.datetime "featured_until"
    t.datetime "resume_database_access_until"
    t.string   "slug",                                     null: false
  end

  add_index "employers", ["slug"], name: "index_employers_on_slug", unique: true, using: :btree

  create_table "employment_types", force: :cascade do |t|
    t.string "title"
  end

  create_table "employment_types_listings", id: false, force: :cascade do |t|
    t.integer "employment_type_id"
    t.integer "listing_id"
  end

  add_index "employment_types_listings", ["listing_id", "employment_type_id"], name: "index_employment_types", unique: true, using: :btree

  create_table "flags", force: :cascade do |t|
    t.integer  "flag_type"
    t.text     "comment"
    t.integer  "listing_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "flags", ["listing_id"], name: "index_flags_on_listing_id", using: :btree
  add_index "flags", ["user_id"], name: "index_flags_on_user_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image_uid"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_name"
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id", using: :btree

  create_table "job_seekers", force: :cascade do |t|
    t.string "first_name",   limit: 50
    t.string "last_name",    limit: 50
    t.string "phone_number", limit: 30
  end

  create_table "jobs", force: :cascade do |t|
    t.text    "job_description"
    t.text    "job_requirements"
    t.integer "employer_id"
    t.text    "job_description_raw"
    t.text    "job_requirements_raw"
    t.integer "questionnaire_id"
    t.string  "slug",                 null: false
    t.string  "application_url"
    t.string  "jobg8_id"
  end

  add_index "jobs", ["employer_id"], name: "index_jobs_on_employer_id", using: :btree
  add_index "jobs", ["slug"], name: "index_jobs_on_slug", unique: true, using: :btree

  create_table "listings", force: :cascade do |t|
    t.string   "title",                                          null: false
    t.integer  "location_id"
    t.text     "keywords"
    t.integer  "actable_id"
    t.string   "actable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "salary"
    t.string   "salary_type",         limit: 10
    t.boolean  "is_priority",                    default: false
    t.boolean  "is_featured",                    default: false
    t.datetime "featured_last_shown"
    t.boolean  "active",                         default: false
    t.datetime "active_until"
    t.datetime "first_activated_at"
    t.integer  "views",                          default: 0,     null: false
  end

  add_index "listings", ["actable_id", "actable_type"], name: "index_listings_on_actable_id_and_actable_type", using: :btree
  add_index "listings", ["location_id"], name: "index_listings_on_location_id", using: :btree

  create_table "listings_occupations", id: false, force: :cascade do |t|
    t.integer "occupation_id"
    t.integer "listing_id"
  end

  add_index "listings_occupations", ["listing_id", "occupation_id"], name: "index_listings_occupations_on_listing_id_and_occupation_id", unique: true, using: :btree

  create_table "locations", force: :cascade do |t|
    t.string "zip_code",     limit: 7
    t.string "city",         limit: 100
    t.string "state",        limit: 50
    t.string "state_code",   limit: 2
    t.string "country",      limit: 50
    t.string "country_code", limit: 2
    t.float  "latitude"
    t.float  "longitude"
  end

  add_index "locations", ["city"], name: "index_locations_on_city", using: :btree
  add_index "locations", ["country"], name: "index_locations_on_country", using: :btree
  add_index "locations", ["state"], name: "index_locations_on_state", using: :btree
  add_index "locations", ["zip_code", "city"], name: "index_locations_on_zip_code_and_city", unique: true, using: :btree
  add_index "locations", ["zip_code"], name: "index_locations_on_zip_code", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "sender",         limit: 20
    t.boolean  "is_read",                   default: false
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["application_id"], name: "index_messages_on_application_id", using: :btree

  create_table "occupations", force: :cascade do |t|
    t.string "title",    limit: 100
    t.string "ancestry"
  end

  add_index "occupations", ["ancestry"], name: "index_occupations_on_ancestry", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionnaire_questions", force: :cascade do |t|
    t.text     "content"
    t.boolean  "required"
    t.integer  "answer_type",      default: 0
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
    t.text     "answers"
  end

  add_index "questionnaire_questions", ["questionnaire_id"], name: "index_screening_questionnaire_questions", using: :btree

  create_table "questionnaires", force: :cascade do |t|
    t.string   "name"
    t.integer  "passing_score"
    t.text     "more_email"
    t.text     "less_email"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questionnaires", ["employer_id"], name: "index_questionnaires_on_employer_id", using: :btree

  create_table "recently_viewed_jobs", force: :cascade do |t|
    t.integer  "job_seeker_id"
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recently_viewed_jobs", ["job_id", "job_seeker_id"], name: "index_recently_viewed_jobs_on_job_id_and_job_seeker_id", unique: true, using: :btree
  add_index "recently_viewed_jobs", ["job_id"], name: "index_recently_viewed_jobs_on_job_id", using: :btree
  add_index "recently_viewed_jobs", ["job_seeker_id"], name: "index_recently_viewed_jobs_on_job_seeker_id", using: :btree

  create_table "resumes", force: :cascade do |t|
    t.text    "objective"
    t.text    "skills"
    t.integer "job_seeker_id"
    t.text    "objective_raw"
    t.text    "skills_raw"
    t.boolean "hidden",           default: false
    t.integer "total_experience"
    t.string  "slug",                             null: false
  end

  add_index "resumes", ["job_seeker_id"], name: "index_resumes_on_job_seeker_id", using: :btree
  add_index "resumes", ["slug"], name: "index_resumes_on_slug", unique: true, using: :btree

  create_table "saved_jobs", force: :cascade do |t|
    t.integer  "job_id"
    t.integer  "job_seeker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "saved_jobs", ["job_id", "job_seeker_id"], name: "index_saved_jobs_on_job_id_and_job_seeker_id", unique: true, using: :btree
  add_index "saved_jobs", ["job_seeker_id"], name: "index_saved_jobs_on_job_seeker_id", using: :btree

  create_table "saved_resumes", force: :cascade do |t|
    t.integer  "resume_id"
    t.integer  "employer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "saved_resumes", ["employer_id"], name: "index_saved_resumes_on_employer_id", using: :btree
  add_index "saved_resumes", ["resume_id", "employer_id"], name: "index_saved_resumes_on_resume_id_and_employer_id", unique: true, using: :btree

  create_table "searches", force: :cascade do |t|
    t.string   "title"
    t.integer  "frequency",    default: 0
    t.datetime "last_sent"
    t.boolean  "active",       default: false
    t.integer  "user_id"
    t.text     "conditions"
    t.string   "target_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "searches", ["token"], name: "index_searches_on_token", unique: true, using: :btree
  add_index "searches", ["user_id"], name: "index_searches_on_user_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "transactions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "description"
    t.integer  "transaction_type"
    t.integer  "amount"
    t.integer  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "provider"
    t.string   "uid"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "send_mailings"
    t.integer  "location_id"
    t.string   "address"
    t.string   "activation_digest"
    t.boolean  "activated"
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "credits",                default: 0
    t.integer  "actable_id"
    t.string   "actable_type"
    t.string   "new_email"
  end

  add_index "users", ["actable_id", "actable_type"], name: "index_users_on_actable_id_and_actable_type", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["location_id"], name: "index_users_on_location_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "videos", force: :cascade do |t|
    t.string   "video_uid"
    t.integer  "videoable_id"
    t.string   "videoable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "video_name"
  end

  add_index "videos", ["videoable_type", "videoable_id"], name: "index_videos_on_videoable_type_and_videoable_id", using: :btree

  create_table "work_experiences", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.string   "job_title"
    t.string   "company_name"
    t.text     "description"
    t.text     "description_raw"
    t.integer  "resume_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "work_experiences", ["resume_id"], name: "index_work_experiences_on_resume_id", using: :btree

end
