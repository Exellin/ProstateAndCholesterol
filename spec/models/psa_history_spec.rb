require 'rails_helper'

RSpec.describe PsaHistory, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:psa_history)).to be_valid
  end
end
