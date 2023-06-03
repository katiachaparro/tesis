class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :form_start
      t.datetime :event_start
      t.datetime :event_end
      t.text :location
      t.text :event_nature
      t.text :threats
      t.text :affected_area
      t.text :isolation
      t.text :objectives
      t.text :strategy
      t.text :tactics
      t.text :pc_location
      t.text :e_location
      t.text :entry_route
      t.text :egress_route
      t.text :security_message
      t.text :communication_channels
      t.string :commander
      t.string :kind
      t.boolean :closed

      t.decimal :longitude
      t.decimal :latitude

      t.timestamps
    end
  end
end
