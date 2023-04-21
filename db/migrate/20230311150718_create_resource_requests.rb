class CreateResourceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :organization, null: true, foreign_key: true
      t.decimal :quantity
      t.decimal :remaining_quantity

      t.timestamps
    end
  end
end
