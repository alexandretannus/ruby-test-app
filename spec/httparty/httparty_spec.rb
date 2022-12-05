describe 'HTTParty' do
    it 'httparty' do
        response = HTTParty.get('https://jsonplaceholder.typicode.com/posts/2')

        contentType = response.headers['content-type']
        
        expect(contentType).to include('application/json')
    end
end