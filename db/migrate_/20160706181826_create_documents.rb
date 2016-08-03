class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :document_uid
      t.string :document_name

      t.references :documentable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
