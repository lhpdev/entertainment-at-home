class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.integer :purchasable_id, index: true, null: false
      t.float :price
      t.string :video_quality

      t.timestamps
    end

    add_reference :purchase_options, :purchaseble, polymorphic: true, index: true
  end
end
