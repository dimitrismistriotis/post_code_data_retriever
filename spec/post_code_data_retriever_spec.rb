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

  context 'retrieve data from uk-postcodes on valid post code' do
    #    .http://uk-postcodes.com/postcode/SE165DY.json
    it 'should issue an http request on legal post code' do
      results = IO.read("#{File.dirname(__FILE__)}/data/uk-postcodes_response-se165dy.json")
      HTTParty.
        should_receive(:get).
        with('http://uk-postcodes.com/postcode/SE165DY.json',)
        .and_return(results)
      process_result = subject.get_coordinates('SE16 5DY')
      expect(process_result.result_code).to equal(0)
      expect(process_result.error).not_to eq('Input provided is not a valid UK post code.')
    end

    #it 'should issue an http request on legal post code with custom format' do
    #  process_result = subject.get_coordinates('se165dy')
    #  expect(process_result.result_code).to equal(0)
    #  expect(process_result.error).not_to eq('Input provided is not a valid UK post code.')
    #end
  end
end