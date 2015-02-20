class CreateOrganizationTags < ActiveRecord::Migration
  def change
    create_table :organization_tags do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :tag, index: true

      t.timestamps null: false
    end
    add_foreign_key :organization_tags, :organizations
    add_foreign_key :organization_tags, :tags
  end
end
