require 'rails_helper'

describe Rent do
  subject(:rent) { build(:rent) }
  
  it { is_expected.to be_valid }

  context 'validates not null fields' do
    it { rent.validates_presence_of :user }
    it { rent.validates_presence_of :book }
    it { rent.validates_presence_of :from }
    it { rent.validates_presence_of :to }
  end

  it {expect(rent.from).to <=(rent.to) }

end
