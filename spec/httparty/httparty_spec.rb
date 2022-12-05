describe 'HTTParty' do
    it 'httparty' do
        stub_request(:get, "https://jsonplaceholder.typicode.com/posts/2")
            .to_return(status: 200, body: "", headers: { 'content-type': 'application/json'})
        
        response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')
        
        contentType = response.headers['content-type']
        
        expect(contentType).to include('application/json')
    end
end