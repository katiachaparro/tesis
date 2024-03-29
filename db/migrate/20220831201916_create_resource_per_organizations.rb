class CreateResourcePerOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_per_organizations do |t|
      t.references :resource, null: false, foreign_key: true, index: false
      t.references :organization, null: false, foreign_key: true, index: false
      t.integer :quantity, default: 0
      t.integer :quantity_used, default: 0
      t.string :state

      t.index [:resource_id, :organization_id], unique: true, name: 'user_permission_index'

      t.timestamps
    end
  end
end
