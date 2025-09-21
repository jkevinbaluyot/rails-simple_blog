class CreateWebSettings < ActiveRecord::Migration[7.2]
  def change
    create_table :web_settings do |t|
      t.string :site_name

      t.timestamps
    end
  end
end
