require 'rails_helper'

RSpec.describe Customer, type: :model do

  fixtures :customers

  it 'Create a customer' do
    customer = customers(:alexandre)

    expect(customer.full_name).to eq("Sr. Alexandre Tannus")
  end
end
