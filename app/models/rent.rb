class Rent < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
  validates :from, presence: true
  validates :to, presence: true

  validate :validate_date_from_is_less_than_date_to

  def validate_date_from_is_less_than_date_to
    errors.add(:to, 'Date from must be less than date to') if from && to && to < from
  end
end
