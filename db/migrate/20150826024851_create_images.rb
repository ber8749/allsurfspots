class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.text :description
      t.string :imgur_id
      t.boolean :approved
      t.references :imageable, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
