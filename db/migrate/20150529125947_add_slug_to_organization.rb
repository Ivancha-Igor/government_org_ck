class AddSlugToOrganization < ActiveRecord::Migration
  def up
    Organization.add_translation_fields! slug: :string
  end

  def down
    remove_column :organization_translations, :slug
  end
end
