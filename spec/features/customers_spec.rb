require 'rails_helper'
require_relative '../support/new_customer_form'

RSpec.feature "Customers", type: :feature, js: true do
  let (:new_customer_form) { NewCustomerForm.new }

  it 'Visit index page' do
    visit(customers_path)
    page.save_screenshot('screenshot.png')
    expect(page).to have_current_path(customers_path)
  end

  context 'Logged actions' do

    before(:each) do
      member = create(:member)
      login_as(member, :scope => :member)
    end

    it 'Creates a customer - Page Object Pattern' do
      
      new_customer_form.login.visit_page.fill_in_with(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        address: Faker::Address.street_name
      ).submit

      expect(page).to have_content('Customer was successfully created.')

    end

    it 'Creates a customer' do
       visit(new_customer_path)

       fill_in('Name', with: Faker::Name.name )
       fill_in('Email', with: Faker::Internet.email )
       fill_in('Address', with: Faker::Address.street_name )

       click_button('Create Customer')

       expect(page).to have_content('Customer was successfully created.')

    end
    
  end

end
