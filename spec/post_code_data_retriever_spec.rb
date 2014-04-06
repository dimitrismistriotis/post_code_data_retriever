require 'spec_helper'
require 'post_code_data_retriever'

describe PostCodeDataRetriever do
  context 'filter illegal post code' do
    it 'should return an error on illegal post code' do
      process_result = subject.get_coordinates('dd')
      expect(process_result.result_code).to equal(-1)
      expect(process_result.error).to eq('Input provided is not a valid UK post code.')
    end
  end

  context 'Data retrieval and parsing for existing post code' do
    before do

      mocked_response = Object.new
      def mocked_response.code
        return 200
      end
      def mocked_response.body
        return IO.read("#{File.dirname(__FILE__)}/data/uk-postcodes_response-se165dy.json")
      end

      HTTParty
        .should_receive(:get)
        .with('http://uk-postcodes.com/postcode/SE165DY.json')
        .and_return(mocked_response)
    end

    context 'retrieve data from uk-postcodes on valid post code' do
      it 'should issue an http request on legal post code' do
        process_result = subject.get_coordinates('SE16 5DY')
        expect(process_result.result_code).to equal(0)
        expect(process_result.error).not_to eq('Input provided is not a valid UK post code.')
      end

      it 'should issue an http request on legal not formatted post code' do
        process_result = subject.get_coordinates('se165dy')
        expect(process_result.result_code).to equal(0)
        expect(process_result.error).not_to eq('Input provided is not a valid UK post code.')
      end
    end

    context 'Mapping retrieved result' do
      it 'map returned result' do
        process_result = subject.get_coordinates('SE16 5DY')
        expect(process_result.result_code).to equal(0)
        expect(process_result.latitude.to_s).to eq('51.505821')
      end
    end
  end

  context 'Response for valid but non-exitant post code' do
    # http://uk-postcodes.com/postcode/SE165DG.json
    before do

      mocked_response = Object.new
      def mocked_response.code() 404 end
      def mocked_response.body() '' end

      HTTParty
        .should_receive(:get)
        .with('http://uk-postcodes.com/postcode/SE165DG.json')
        .and_return(mocked_response)
    end

    it 'return error with non existent flag' do
      process_result = subject.get_coordinates('SE16 5DG')
      expect(process_result.result_code).to equal(-4)
    end
  end

  context 'Full integration' do
    it 'should dispatch HTTP request with correct input' do
      VCR.use_cassette('se163ln_response') do
        response = Net::HTTP.get_response(
          URI('http://uk-postcodes.com/postcode/SE163LN.json'))
        expect(response.body).to  match /SE16 3LN/
      end
    end
  end
end