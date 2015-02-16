class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps null: false
    end
  end
end
