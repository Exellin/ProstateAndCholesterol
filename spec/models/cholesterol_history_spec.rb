require 'rails_helper'

RSpec.describe CholesterolHistory, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:cholesterol_history)).to be_valid
  end
end
