class User < ApplicationRecord
  include UserQrCode
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :recoverable, :rememberable, :validatable, :lockable, :confirmable
end
