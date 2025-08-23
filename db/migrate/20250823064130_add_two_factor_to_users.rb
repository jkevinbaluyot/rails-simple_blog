class AddTwoFactorToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :otp_secret, :string
    add_column :users, :otp_required_for_login, :boolean, default: false
    add_column :users, :otp_backup_codes, :text, array: true, default: []
  end
end
