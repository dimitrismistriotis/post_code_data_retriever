require 'post_code_data_retriever/version'
require 'retrieval_result'
require 'post_code_validator'
require 'json'
require 'httparty'

module PostCodeDataRetriever
  def self.get_coordinates(post_code)

    post_code.gsub!(/\s+/, '')
    post_code.upcase!

    # puts "retrieving coordinates of #{post_code}"

    unless PostCodeValidator.valid_post_code(post_code)
      return RetrievalResult.new(-1, 'Input provided is not a valid UK post code.')
    end

    response = nil
    begin
      # puts "http://uk-postcodes.com/postcode/#{post_code}.json"
      response = HTTParty.get("http://uk-postcodes.com/postcode/#{post_code}.json")
    rescue StandardError => se
      # puts se.message
      # puts se.backtrace[0..10].join("\n")
      return RetrievalResult.new(-2, 'Connection error while retrieving post codes from uk-postcodes.com')
    end

    # puts response
    case response.code
    when 200
      return map_uk_postcodes_response_to_result(response.body)
    end


    RetrievalResult.new
  end

  ##
  # Maps response of uk-postcodes.com to result returned from this module
  #
  def self.map_uk_postcodes_response_to_result(input)
    geoloc_json_data = JSON.parse(input)
    # puts geoloc_json_data

    RetrievalResult.new(-999, 'Not implemented yet.')
  end
end
