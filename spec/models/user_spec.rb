require 'rails_helper'

describe User do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_inclusion_of(:locale).in_array(%w[es en]) }
end
