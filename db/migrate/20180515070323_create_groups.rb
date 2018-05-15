class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.string :sentence

      t.timestamps
    end
  end
end
