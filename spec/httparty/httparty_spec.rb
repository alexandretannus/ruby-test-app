describe 'HTTParty' do
    it 'httparty' do
        # stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2")
        #     .to_return(status: 200, body: "", headers: { 'content-type': 'application/json'})
        VCR.use_cassette("jsonplaceholder/posts") do
            response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
            
            contentType = response.headers['content-type']
            
            expect(contentType).to include('application/json')
            
        end
    end

    it 'HTTParty - VCR - config metadata', :vcr do
        response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
        
        contentType = response.headers['content-type']
        
        expect(contentType).to include('application/json')
        
    end

    it 'HTTParty - VCR - config metadata - using existing cassette', vcr: { cassette_name: 'jsonplaceholder/posts' } do
        response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
        
        contentType = response.headers['content-type']
        
        expect(contentType).to include('application/json')
        
    end

    it 'HTTParty - VCR - config metadata - match request on body', vcr: { cassette_name: 'jsonplaceholder/posts', match_requests_on: [:body] } do
        response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/4')
        
        contentType = response.headers['content-type']
        
        expect(contentType).to include('application/json')
        
    end
end