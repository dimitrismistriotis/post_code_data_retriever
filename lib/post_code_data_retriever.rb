require "post_code_data_retriever/version"
require 'retrieval_result'
require 'post_code_validator'

module PostCodeDataRetriever
  def self.get_coordinates(post_code)
    unless PostCodeValidator.valid_post_code(post_code)
      return RetrievalResult.new(-1, 'Input provided is not a valid UK post code.')
    end

    # "retrieving coordinates of #{post_code}"
    RetrievalResult.new
  end
end
