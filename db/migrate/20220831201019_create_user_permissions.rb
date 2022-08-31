class CreateUserPermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :user_permissions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
