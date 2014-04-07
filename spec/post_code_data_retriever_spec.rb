require 'spec_helper'
require 'post_code_data_retriever'

describe PostCodeDataRetriever do
  context 'should filter illegal post code' do
    it 'should return an error on illegal post code' do
      process_result = subject.get_coordinates('dd')
      expect(process_result.result_code).to equal(-1)
      expect(process_result.error).to eq('Input provided is not a valid UK post code.')
    end
  end

  context 'Data retrieval and parsing for existing post code' do
    context 'retrieve data from uk-postcodes on valid post code' do
      it 'should issue an http request on legal post code' do
        VCR.use_cassette('se165dy_response') do
          process_result = subject.get_coordinates('SE16 5DY')
          expect(process_result.result_code).to equal(0)
          expect(process_result.error).not_to eq(
            'Input provided is not a valid UK post code.')
        end
      end

      it 'should issue an http request on legal not formatted post code' do
        VCR.use_cassette('se165dy_response') do
          process_result = subject.get_coordinates('se165dy')
          expect(process_result.result_code).to equal(0)
          expect(process_result.error).not_to eq(
            'Input provided is not a valid UK post code.')
        end
      end
    end

    context 'Mapping retrieved result' do
      it 'map returned result' do
        VCR.use_cassette('se165dy_response') do
          process_result = subject.get_coordinates('SE16 5DY')
          expect(process_result.result_code).to equal(0)
          expect(process_result.latitude.to_s).to eq('51.505822348111835')
        end
      end
    end
  end

  context 'Response for valid but non-exitant post code' do

    # http://uk-postcodes.com/postcode/SE165DG.json
    #
    it 'should return error with non existent flag' do
      VCR.use_cassette('se165dg_response') do
        process_result = subject.get_coordinates('SE16 5DG')
        expect(process_result.result_code).to equal(-4)
      end
    end
  end

  context 'Intgration for existent post code' do
    it 'should dispatch HTTP request with correct input' do
      VCR.use_cassette('se163ln_response') do
        post_code_data = PostCodeDataRetriever.get_coordinates('SE163LN')
        expect(post_code_data.result_code).to equal(0)
      end
    end
  end
end