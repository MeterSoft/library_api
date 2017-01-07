class Book < ApplicationRecord
  belongs_to :category

  validates :title, :description, :file, presence: true

  mount_uploader :file, BookUploader

  def file_url
    file.url
  end
end
