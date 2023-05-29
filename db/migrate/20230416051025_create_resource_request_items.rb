class CreateResourceRequestItems < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_request_items do |t|
      t.references :resource_request, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.integer :quantity, default: 0
      t.integer :quantity_used, default: 0

      t.timestamps
    end
  end
end
