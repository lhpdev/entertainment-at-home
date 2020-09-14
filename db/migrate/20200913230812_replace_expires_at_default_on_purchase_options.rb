class ReplaceExpiresAtDefaultOnPurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    change_column :purchase_options, :expires_at, :string, default: nil, null: true
  end
end
