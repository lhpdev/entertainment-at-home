class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.integer :season_id, index: true, null: false
      t.string :title
      t.string :plot
      t.integer :episode_number

      t.timestamps
    end

    add_foreign_key :episodes, :seasons
  end
end
