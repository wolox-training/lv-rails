class Book < ApplicationRecord
  include Filterable

  validates :genre, :author, :image, :title, :publisher, :year, presence: true

  has_one :rent, dependent: :destroy
end
