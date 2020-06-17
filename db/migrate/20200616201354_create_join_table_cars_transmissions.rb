class CreateJoinTableCarsTransmissions < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cars, :transmissions do |t|
      t.index :car_id
      t.index :transmission_id
    end
  end
end
