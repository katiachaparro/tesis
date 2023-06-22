class CreateResourceRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :resource_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.references :organization, null: true, foreign_key: true
      t.string :sender
      t.string :status
      t.string :code

      t.timestamps
    end
  end
end
