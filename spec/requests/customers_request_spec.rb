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
            member = create(:member)
            sign_in member
        end

        context 'show routes' do

            it 'responds a 200 status (ok)' do
                customer = create(:customer)
                get customer_path(customer) , params: { :id => customer.id } 
                expect(response).to have_http_status(:ok)
            end

            it 'render show template' do
                customer = create(:customer)
                get customer_path(customer) , params: { :id => customer.id } 
                expect(response).to render_template(:show)
            end

        end
    end

end
