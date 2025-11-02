class CreateTechnologies < ActiveRecord::Migration[7.2]
  def change
    create_table :technologies do |t|
      t.string :title

      t.timestamps
    end
  end
end
