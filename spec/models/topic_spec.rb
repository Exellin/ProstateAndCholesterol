require 'rails_helper'

RSpec.describe Topic, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.build(:topic)).to be_valid
  end
end