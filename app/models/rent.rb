class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :from, presence: true
  validates :to, presence: true
end
