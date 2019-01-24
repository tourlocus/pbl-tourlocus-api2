class CreatePresents < ActiveRecord::Migration[5.2]
  def change
    create_table :presents do |t|
      t.string :name
      t.string :image
      t.string :kind
      t.string :other_kind
      t.string :target
      t.string :other_target
      t.string :price
      t.string :content
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
