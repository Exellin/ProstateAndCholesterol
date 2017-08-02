require 'rails_helper'

RSpec.describe Medication, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:medication)).to be_valid
  end
end
