class Territories < ActiveRecord::Migration
  def change
    create_table :territories do |t|
      t.integer :number
      t.string :designation
      t.integer :user_id
      # t. :image

      t.timestamps
    end
  end
end
