class CreateVictims < ActiveRecord::Migration[6.1]
  def change
    create_table :victims do |t|
      t.string :name
      t.string :sex
      t.integer :age
      t.string :classification
      t.boolean :treated_on_site
      t.string :place_of_transfer
      t.string :transferred_by
      t.string :place_of_registration
      t.datetime :date
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
