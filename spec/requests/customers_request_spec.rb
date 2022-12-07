require 'rails_helper'

RSpec.describe '/customers', type: :request do
    it 'responds succesfully' do
        get '/customers'
        expect(response).to be_success
    end

    it 'responds a 200 status' do
        get '/customers'
        expect(response).to have_http_status(200)
    end
end
