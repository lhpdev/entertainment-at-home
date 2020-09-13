class CreateLibraries < ActiveRecord::Migration[6.0]
  def change
    create_table :libraries do |t|
      t.integer :user_id, index: true, null: false

      t.timestamps
    end

    add_foreign_key :libraries, :users
  end
end
