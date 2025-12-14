class AddFieldToWebsiteSetting < ActiveRecord::Migration[7.2]
  def change
    add_column :web_settings, :site_description, :text
    add_column :web_settings, :site_year, :string, default: "2025"
    add_column :web_settings, :main_domain_name, :string
    add_column :web_settings, :main_domain_link, :string
  end
end
