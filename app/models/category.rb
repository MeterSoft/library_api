class Category < ApplicationRecord
  has_many :books

  validates :title, presence: true, uniqueness: true

  def books_count
    self.books.count
  end
end
