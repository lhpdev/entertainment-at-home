class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.integer :library_id, index: true
      t.float :price
      t.string :video_quality
      t.datetime :expires_at, default: DateTime.current + 2.days, null: false
      t.timestamps
    end

    add_reference :purchase_options, :purchaseble, polymorphic: true
  end
end
