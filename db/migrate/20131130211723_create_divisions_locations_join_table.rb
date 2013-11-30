class CreateDivisionsLocationsJoinTable < ActiveRecord::Migration
  def up
    create_table :divisions_locations, :id => false do |t|
      t.references :division
      t.references :location
    end
    add_index :divisions_locations, [:division_id, :location_id]
    add_index :divisions_locations, :division_id
  end

  def down
    drop_table :divisions_locations
  end
end
