class CreateAssistRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :assist_requests do |t|
      t.references :resource_request_item, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true
      t.string :code
      t.boolean :arrived
      t.datetime :arrival_date
      t.string :vehicle_registration
      t.integer :number_of_people
      t.string :status
      t.string :assigned_to
      t.datetime :demobilization_date
      t.boolean :demobilized
      t.string :demobilizing_person
      t.string :comments

      t.timestamps
    end
  end
end
