class RentSerializer < ActiveModel::Serializer
  attributes :from, :to
  belongs_to :user, serializer: UserSerializer
  belongs_to :book, serializer: BookSerializer
end
