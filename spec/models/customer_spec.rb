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

  it 'Create a customer - factory - sobrescrever atributo' do
    customer = create(:customer, name: "Alexandre")

    expect(customer.full_name).to eq("Sr. Alexandre")
  end

  it 'Create a customer - factory - alias user' do
    customer = create(:user)

    expect(customer.full_name).to start_with("Sr.")
  end

  it 'Create a customer - herança em factory - false vip' do
    customer = create(:customer_default)

    expect(customer.vip).to be_falsey
  end

  it 'Create a customer - herança em factory - true vip' do
    customer = create(:customer_vip)

    expect(customer.vip).to be_truthy
  end

  it 'Create a customer - attributes for' do
    attrs = attributes_for(:customer)
    customer = Customer.create(attrs)

    expect(customer.vip).to be_nil
    expect(customer.full_name).to start_with("Sr.")
  end

  it 'Create a customer - atributo transitorio' do
    customer = create(:customer_default, upcased: true)


    expect(customer.name.upcase).to eq(customer.name)
    expect(customer.full_name).to start_with("Sr.")
  end

  it 'Create a customer - traits - cliente masculino, vip' do
    customer = create(:customer_male_vip)

    expect(customer.gender).to eq('M')
    expect(customer.vip).to be_truthy

  end

  it 'Create a customer - traits - cliente feminino vip' do
    customer = create(:customer_female_vip)

    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_truthy

  end

  it 'Create a customer - traits - cliente feminino default' do
    customer = create(:customer_female_default)

    expect(customer.gender).to eq('F')
    expect(customer.vip).to be_falsey

  end

  it { expect{ create(:customer) }.to change {Customer.all.size}.by(1) }
end
