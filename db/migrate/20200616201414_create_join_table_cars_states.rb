class CreateJoinTableCarsStates < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cars, :states do |t|
      t.index :car_id
      t.index :state_id
    end
  end
end
