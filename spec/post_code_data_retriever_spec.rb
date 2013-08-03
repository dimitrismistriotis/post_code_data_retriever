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
#{"postcode"=>"SE16 5DY", "geo"=>{"lat"=>"51.505821", "lng"=>"-0.034702", "easting"=>"536493", "northing"=>"180374", "geohash"=>"http://geohash.org/gcpvp0qepkum"}, "administrative"=>{"constituency"=>{"title"=>"Bermondsey and Old Southwark", "uri"=>"http://data.ordnancesurvey.co.uk/doc/7000000000025037", "code"=>"25037"}, "district"=>{"title"=>"Southwark", "uri"=>"http://statistics.data.gov.uk/id/local-authority/00BE", "snac"=>"00BE"}, "ward"=>{"title"=>"Surrey Docks", "uri"=>"http://statistics.data.gov.uk/id/electoral-ward/00BEGX", "snac"=>"00BEGX"}}}
    it 'should issue an http request on legal post code' do
      HTTParty.
        should_receive(:get).
        with('http://uk-postcodes.com/postcode/SE165DY.json',)
        .and_return('results')
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