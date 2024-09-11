class CreateTroopTrackImports < ActiveRecord::Migration[7.0]
  def change
    create_table :troop_track_imports do |t|
      t.string :tt_import
      t.json :data
      t.string :export_uuid
      t.integer :organizer_signup_id

      t.timestamps
    end
    add_index :troop_track_imports, :export_uuid
    add_index :troop_track_imports, :organizer_signup_id
  end
end
