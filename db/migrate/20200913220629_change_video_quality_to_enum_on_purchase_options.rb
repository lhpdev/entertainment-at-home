class ChangeVideoQualityToEnumOnPurchaseOptions < ActiveRecord::Migration[6.0]
  def up
    change_column :purchase_options, :video_quality, :integer, using: 'video_quality::integer'
  end

  def down
    change_column :purchase_options, :video_quality, :string
  end
end
