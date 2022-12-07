require 'rails_helper'
require 'rspec/rails'

RSpec.describe CustomersController, type: :request do
    describe 'as a guest' do
        context '#index' do
            it 'responds succesfully' do
                get customers_path
                expect(response).to be_successful
            end       

            it 'responds a 200 status' do
                get customers_url
                expect(response).to have_http_status(:ok)
            end

            it 'responds a 302 status (not authorized)' do
                customer = create(:customer)
                get customer_path(customer) , params: { :id => customer.id } 
                expect(response).to have_http_status(:found)
            end

        end
    end

    describe 'as a logged user' do
        before(:each) do
            @customer = create(:customer)
            member = create(:member)
            sign_in member
        end

        context 'show routes' do

            it 'responds a 200 status (ok)' do
                get customer_path(@customer) , params: { :id => @customer.id } 
                expect(response).to have_http_status(:ok)
            end

            it 'render show template' do
                get customer_path(@customer) , params: { :id => @customer.id } 
                expect(response).to render_template(:show)
            end

        end

        context '#post' do
            it 'with valid atributes' do
                expect{
                    post customers_path, params: { customer: attributes_for(:customer) }
                }.to change(Customer, :count).by(1)
            end

            it 'with invalid atributes' do
                customer_attributes = attributes_for(:customer, address: nil)
                expect{
                    post customers_path, params: { customer: customer_attributes }
                }.not_to change(Customer, :count)
            end

            it 'flash notice' do
                post customers_path, params: { customer: attributes_for(:customer) }
                expect(flash[:notice]).to match(/successfully created/)
            end

            it 'content-type' do
                post customers_path, as: :json , params: { customer: attributes_for(:customer) } 
                expect(response.content_type).to eq('application/json')
            end
        end


    end

end
