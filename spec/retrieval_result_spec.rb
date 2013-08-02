require 'spec_helper'
require 'retrieval_result'

describe RetrievalResult do
  it { should respond_to(:error) }
  it { should respond_to(:result_code) }
end
