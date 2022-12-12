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

            it 'responds succesfully json matchers' do
                get "/customers.json"
                expect(response).to be_successful
                expect(response.body).to include_json([
                    name: (be_kind_of String),
                    email: (be_kind_of String)
                ])
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

            it 'JSON Schema' do
                get "/customers/#{@customer.id}.json"
                expect(response).to be_successful
                expect(response).to match_response_schema("customer")
            end  

            it 'responds succesfully json matchers' do
                get "/customers/#{@customer.id}.json"
                expect(response).to be_successful
                expect(response.body).to include_json(
                    id: /\d/,
                    name: (be_kind_of String),
                    email: (be_kind_of String)
                )
            end  
            
            it 'responds succesfully json - rspec puro' do
                get "/customers/#{@customer.id}.json"

                response_body = JSON.parse(response.body)

                expect(response).to be_successful
                expect(response_body.fetch("id")).to eq(@customer.id) 
                expect(response_body.fetch("name")).to be_kind_of(String)
                expect(response_body.fetch("email")).to be_kind_of(String) 

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

            it 'create - json' do
                headers = { "ACCEPT" => "application/json" }

                customer_params = attributes_for(:customer)

                post "/customers.json", params: { customer: customer_params }, headers: headers
                
                expect(response).to have_http_status(201)
                expect(response.body).to include_json(
                    id: /\d/,
                    name: customer_params[:name],
                    email: customer_params[:email]
                )
            end
        end

        context '#update' do
            it 'patch - json' do
                headers = { "ACCEPT" => "application/json" }
    
                customer = Customer.first
                customer.name += " - Atualizado"
    
                patch "/customers/#{customer.id}.json", params: { customer: customer.attributes }, headers: headers
                
                expect(response).to have_http_status(200)
                expect(response.body).to include_json(
                    id: /\d/,
                    name: customer[:name],
                    email: customer[:email]
                )
            end
        end

        context '#destroy' do
            it 'destroy - json' do
                headers = { "ACCEPT" => "application/json" }
    
                customer = Customer.first
    
                expect { delete "/customers/#{customer.id}.json", headers: headers }
                    .to change(Customer, :count).by(-1)
                
                expect(response).to have_http_status(:no_content)
            end
        end

    end

end
