class CreateTransmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :transmissions do |t|
      t.string :transmission

      t.timestamps
    end
  end
end
