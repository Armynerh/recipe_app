class AddUnitToFood < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :unit, :string
    add_column :foods, :rails, :string
  end
end
