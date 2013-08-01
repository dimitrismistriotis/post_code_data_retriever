require "post_code_data_retriever/version"
require 'retrieval_result'

module PostCodeDataRetriever
  def self.get_coordinates(post_code)
    # "retrieving coordinates of #{post_code}"
    RetrievalResult.new
  end
end
