require 'rails_helper'

RSpec.feature "Visitor clicks the 'My Cart' button for a product on the home page and the cart increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They see the cart increasing by 1 after clicking the 'My Cart' button" do

  
    # ACT
    visit root_path

    expect(find('#navbar')).to have_content 'My Cart (0)'
    
    # DEBUG
    find('.btn-primary', match: :first).click

    # VERIFY
    expect(find('#navbar')).to have_content 'My Cart (1)'
    # expect(page).to have_content('Products')
  end
end