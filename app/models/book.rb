class Book < ApplicationRecord
  belongs_to :category

  validates :title, :description, presence: true
end
