require 'rails_helper'

RSpec.describe Product, type: :model do

  context 'Validations with Rspec' do
    it 'is valid with desrciption, price and category' do
      product = create(:product)
  
      expect(product).to be_valid
    end
  
    it 'is invalid without desrciption' do
      product = build(:product, description: nil)
      product.valid?
      
      expect(product.errors[:description]).to include("can't be blank")
    end

    it 'is invalid without price' do
      product = build(:product, price: nil)
      product.valid?
      
      expect(product.errors[:price]).to include("can't be blank")
    end

    it 'is invalid without category' do
      product = build(:product, category: nil)
      product.valid?
      
      expect(product.errors[:category]).to include("can't be blank")
    end
  end

  context 'Validations with Shoulda Matchers' do
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:category) }

    it { is_expected.to belong_to(:category) }
  end

  context 'Instance Methods' do
    it 'return a product with a full description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - $#{product.price}")
    end
  end

end
