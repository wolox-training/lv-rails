class RentSerializer < ActiveModel::Serializer
  attributes :user, :book, :from, :to
end
