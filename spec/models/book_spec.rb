require 'rails_helper'

describe 'Book' do
  subject(:book) { create(:book) }

  context 'Create a book with Faker' do
    it do
      # It's strange but the model tells year is a String
      expect(book.year).to be_instance_of(String)
    end
end
