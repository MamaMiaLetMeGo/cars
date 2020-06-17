class CreateCars < ActiveRecord::Migration[6.0]
  def change
    create_table :cars do |t|
      t.string :title
      t.text :description
      t.string :model
      t.integer :price
      t.integer :year
      t.string :color
      t.integer :miles

      t.timestamps
    end
  end
end
