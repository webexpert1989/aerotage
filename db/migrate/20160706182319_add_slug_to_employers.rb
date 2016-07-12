class AddSlugToEmployers < ActiveRecord::Migration
  def up
    change_column :employers, :company_name, :string, limit: 100, null: false
    add_column :employers, :slug, :string, null: false
    add_index :employers, :slug, unique: true

    change_column :communities, :title, :string, limit: 100, null: false
    change_column :communities, :slug, :string, null: false

    change_column :blog_posts, :title, :string, limit: 100, null: false
    add_column :blog_posts, :slug, :string, null: false
    add_index :blog_posts, :slug, unique: true

    change_column :listings, :title, :string, null: false
    add_column :jobs, :slug, :string, null: false
    add_index :jobs, :slug, unique: true
    add_column :resumes, :slug, :string, null: false
    add_index :resumes, :slug, unique: true
  end

  def down
    remove_column :employers, :slug
    remove_column :blog_posts, :slug
    remove_column :jobs, :slug
    remove_column :resumes, :slug
  end
end
