class CreateResources < ActiveRecord::Migration[6.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.string :description
      t.string :kind
      t.boolean :active

      t.timestamps
    end
  end
end
