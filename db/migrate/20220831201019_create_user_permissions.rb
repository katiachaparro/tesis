class CreateUserPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_permissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :role
      t.boolean :active

      t.index [:user_id, :organization_id], unique: true, name: 'user_organization_index'

      t.timestamps
    end
  end
end
