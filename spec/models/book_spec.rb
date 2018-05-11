require 'rails_helper'

describe Book do
  subject(:book) { build(:book) }

  it { is_expected.to be_valid }

  context 'validates not null fields' do
    it { book.validates_presence_of :genre }
    it { book.validates_presence_of :author }
    it { book.validates_presence_of :image }
    it { book.validates_presence_of :publisher }
    it { book.validates_presence_of :year }
  end
end
