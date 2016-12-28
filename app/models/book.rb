class Book < ApplicationRecord
  belongs_to :category

  validates :title, :description, presence: true

  mount_uploader :file, BookUploader
end
