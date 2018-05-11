require 'rails_helper'

describe User do
  subject(:user) { build(:user) }

  it { is_expected.to be_valid }

  context 'validates not null fields' do
    it { user.validates_presence_of :first_name }
    it { user.validates_presence_of :last_name }
  end
end
