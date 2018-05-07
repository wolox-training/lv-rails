require 'rails_helper'

describe Book do
  subject(:unLibro) { Book.new }

  context 'With an empty book' do
    it '#attr_getters' do
      %w[genre author image title publisher year].each do |un_atr|
        expect(unLibro.attributes.keys).to include(un_atr)
      end
    end
  end
end
