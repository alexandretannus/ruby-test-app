require 'rails_helper'

RSpec.describe Customer, type: :model do

  fixtures :customers

  it 'Create a customer' do
    customer = customers(:alexandre)

    expect(customer.full_name).to eq("Sr. Alexandre Tannus")
  end

  it 'Create a customer - factory' do
    customer = create(:customer)

    expect(customer.full_name).to start_with("Sr.")
  end

  it { expect{ create(:customer) }.to change {Customer.all.size}.by(1) }
end
