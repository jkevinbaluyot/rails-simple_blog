# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
password = SecureRandom.alphanumeric(12)
email = ENV['ADMIN_EMAIL']

User.create!(
  email: email,
  password: password,
  password_confirmation: password,
  confirmed_at: Time.current,
  confirmation_sent_at: Time.current - 1.hour
)

p '====== User Created ======'
p "Email: #{email}"
p "Password: #{password}"
