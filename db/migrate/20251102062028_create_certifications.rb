class CreateCertifications < ActiveRecord::Migration[7.2]
  def change
    create_table :certifications do |t|
      t.string :title
      t.string :teacher
      t.string :image_url
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
