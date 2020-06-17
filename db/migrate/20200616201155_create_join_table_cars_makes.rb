class CreateJoinTableCarsMakes < ActiveRecord::Migration[6.0]
  def change
    create_join_table :cars, :makes do |t|
      t.index :car_id
      t.index :make_id
    end
  end
end
