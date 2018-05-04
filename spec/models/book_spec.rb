require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:unLibro) { Book.new }

  context 'Model Book attr test' do
    
    it '.attributes' do
      # This test it is not effective. We could test the attributes of a book in irb
      # This test only verifies rspec correctly installed
      
      ["genre", "author", "image", "title", "publisher", "year"].each do |unAtr|
        expect(unLibro.attributes.keys).to include(unAtr)
      end
    end

  end
end
