class CreateResourcePerOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_per_organizations do |t|
      t.references :resource, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :quantity_available
      t.string :state

      t.timestamps
    end
  end
end
