class CreateSpots < ActiveRecord::Migration
  def change
    create_table :spots do |t|
      t.string :name
      t.string :aliases
      t.text :description
      t.string :continent
      t.string :country
      t.string :state
      t.string :city
      t.string :address
      t.float :lat
      t.float :lng
      t.string :wave_direction, array: true, default: []
      t.string :kind, array: true, default: []
      t.string :bottom, array: true, default: []
      t.string :consistency, array: true, default: []
      t.string :quality, array: true, default: []
      t.string :crowd, array: true, default: []
      t.string :access, array: true, default: []
      t.string :tide, array: true, default: []
      t.string :tide_direction, array: true, default: []
      t.string :power, array: true, default: []
      t.string :wind_direction, array: true, default: []
      t.string :swell_direction, array: true, default: []
      t.string :swell_size, array: true, default: []
      t.string :ability, array: true, default: []
      t.string :locals, array: true, default: []
      t.string :paddle_out, array: true, default: []
      t.string :water_quality, array: true, default: []
      t.boolean :approved, default: true
      t.integer :created_by

      t.timestamps
    end
  end
end
