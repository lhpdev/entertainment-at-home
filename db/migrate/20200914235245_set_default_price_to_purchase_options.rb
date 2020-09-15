class SetDefaultPriceToPurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    change_column :purchase_options, :price, :float, default: 2.99
  end
end
