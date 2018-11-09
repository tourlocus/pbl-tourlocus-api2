class CreatePresents < ActiveRecord::Migration[5.2]
  def change
    create_table :presents do |t|
      t.string :name
      t.integer :price
      t.integer :num
      t.string :target
      t.string :content
      t.string :image
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
