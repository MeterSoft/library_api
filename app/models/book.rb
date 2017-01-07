class Book < ApplicationRecord
  belongs_to :category

  validates :title, :description, :file, presence: true

  mount_uploader :file, BookUploader

  def file_url
    "https://library-api-dev.herokuapp.com" + file.url
  end
end
