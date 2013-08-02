require "spec_helper"
require 'post_code_data_retriever'

describe PostCodeDataRetriever do
  context 'filter illegal post code' do
    it 'should return an error on illegal post code' do
      process_result = subject.get_coordinates('dd')
      expect(process_result.result_code).to equal(-1)
      expect(process_result.error).to equal('Input provided is not a post code.')
    end
  end
end