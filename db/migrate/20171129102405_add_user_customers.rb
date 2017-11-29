class AddUserCustomers < ActiveRecord::Migration
  def change
      create_table :users do |t|
      t.string :name
      t.string :email
      t.references :customer, index: true, foreign_key: true
    end
  end
end
