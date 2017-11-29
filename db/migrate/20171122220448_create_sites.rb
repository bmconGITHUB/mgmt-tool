class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :address
      t.string :contact
      t.string :phone
      t.string :email
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
