require 'rails_helper'

describe 'Book' do

  before(:all) do
    @book1 = create(:book)
  end
  subject(:book) { create(:book) }

  context 'Faker and Factory test' do
    it do
      expect(book.attributes).to be_present
    end
  end
end
