require 'rails_helper'

describe Rent do
  subject(:rent) { build(:rent) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of :user }
  it { is_expected.to validate_presence_of :book }
  it { is_expected.to validate_presence_of :from }
  it { is_expected.to validate_presence_of :to }

  it { expect(rent.from).to be <= rent.to }

  describe '#validate_date_from_is_less_than_date_to' do
    it 'validations succes' do
      rent = create(:rent)
      rent.from = Date.new(2018, 1, 20)
      rent.to = Date.new(2018, 1, 25)
      expect(rent).to be_valid
    end

    it 'validations failed' do
      rent = create(:rent)
      rent.from = Date.new(2018, 1, 20)
      rent.to = Date.new(2018, 1, 10) # Smaller than from
      expect { rent.validate! }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: To Date from must be less than date to') # rubocop:disable Metrics/LineLength
    end
  end
end
