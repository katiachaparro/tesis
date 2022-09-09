class CreateEventActions < ActiveRecord::Migration[6.1]
  def change
    create_table :event_actions do |t|
      t.text :description
      t.datetime :date
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
