class CreateResourceRequestItems < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_request_items do |t|
      t.references :resource_request, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true
      t.decimal :quantity
      t.decimal :remaining_quantity

      t.timestamps
    end
  end
end
