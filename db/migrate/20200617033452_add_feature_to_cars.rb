class AddFeatureToCars < ActiveRecord::Migration[6.0]
  def change
    add_column :cars, :feature, :boolean
  end
end
