class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.references :parent_organization, null: true, index: true, foreign_key: { to_table: :organizations }

      t.timestamps
    end
  end
end