class BookSerializer < ActiveModel::Serializer
  attributes :genre, :title, :author
end
