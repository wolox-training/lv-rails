require 'rails_helper'

describe Rent do
  subject(:rent) { build(:rent) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :book }
  it { is_expected.to validate_presence_of :from }
  it { is_expected.to validate_presence_of :to }

  it { expect(rent.from).to be <= rent.to }

  context '#validates' do
    def swap_from_to(rent)
      aux = rent.from
      rent.from = rent.to
      rent.to = aux
    end

    it 'date from is bigger than date to' do
      rent = create(:rent)
      swap_from_to(rent)
      expect { rent.validate! }.to  \
        raise_error(ActiveRecord::RecordInvalid, \
                    'Validation failed: To Date from must be less than date to')
    end
  end
end
