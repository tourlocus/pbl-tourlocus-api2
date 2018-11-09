class CreateMediaFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :media_files do |t|
      t.string :media
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
