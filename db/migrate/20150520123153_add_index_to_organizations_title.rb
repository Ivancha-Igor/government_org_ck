class AddIndexToOrganizationsTitle < ActiveRecord::Migration
  def change
    add_index :organizations, :title, order: { title: :asc }
  end
end
