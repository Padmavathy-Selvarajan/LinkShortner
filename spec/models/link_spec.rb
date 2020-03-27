require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'is valid with option' do 
    link = FactoryBot.build(:link)
    click = FactoryBot.build(:click)
    link.clicks << click
    expect(link).to be_valid
    expect(click).to be_valid
  end

  it 'is invalid without option' do 
    link = FactoryBot.build(:link, given_url: nil)
    expect(link).to be_invalid
  end

end
