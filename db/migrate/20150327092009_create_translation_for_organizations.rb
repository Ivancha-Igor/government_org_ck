class CreateTranslationForOrganizations < ActiveRecord::Migration
  def up
    Organization.create_translation_table!({
                                               title: :string,
                                               description: :text,
                                               address: :string
                                           }, {
                                                migrate_data: true
                                           })
  end

  def down
    Organization.drop_translation_table! migrate_data: true
  end
end
