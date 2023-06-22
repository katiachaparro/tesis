class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :description
      t.references :parent_organization, null: true, index: true, foreign_key: { to_table: :organizations }
      t.boolean :allow_sub_organizations

      t.string     :address
      t.string     :phone

      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
