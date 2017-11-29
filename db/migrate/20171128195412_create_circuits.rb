class CreateCircuits < ActiveRecord::Migration
  def change
    create_table :circuits do |t|
      t.string :ref
      t.string :type
      t.string :speed
      t.string :carrier
      t.string :carrierRef
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
