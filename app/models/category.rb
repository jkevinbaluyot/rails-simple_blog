class Category < ApplicationRecord
    has_many :articles, dependent: :nullify
end
