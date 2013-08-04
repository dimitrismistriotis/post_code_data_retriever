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

  context 'Data retrieval and parsing' do
    before do

      mocked_response = Object.new
      def mocked_response.code
        return 200
      end
      def mocked_response.body
        return IO.read("#{File.dirname(__FILE__)}/data/uk-postcodes_response-se165dy.json")
      end

      HTTParty.
        should_receive(:get).
        with('http://uk-postcodes.com/postcode/SE165DY.json')
        .and_return(mocked_response)
    end

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
end