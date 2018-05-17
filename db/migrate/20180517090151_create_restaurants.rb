class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :area
      t.string :station
      t.integer :phone_number

      t.timestamps
    end
  end
end
